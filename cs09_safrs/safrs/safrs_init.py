import logging
import os
import sys
from flask_swagger_ui import get_swaggerui_blueprint
from flask import Flask, g
from flask.json import JSONEncoder
from flask_sqlalchemy import SQLAlchemy
from .request import SAFRSRequest
from .response import SAFRSResponse
from .json_encoder import SAFRSJSONEncoder
from .jsonapi_filters import FilteringStrategy


class SAFRS:
    """This class configures the Flask application to serve SAFRSBase instances
    :param app: a Flask application.
    :param prefix: URL prefix where the swagger should be hosted. Default is '/api'
    :param LOGLEVEL: loglevel configuration variable, values from logging module (0: trace, .. 50: critical)
    """

    # Configuration settings, these can be overridden in config.py
    MAX_PAGE_LIMIT = 250
    MAX_PAGE_OFFSET = 2 ** 31
    ENABLE_RELATIONSHIPS = True
    ENABLE_METHODS = True
    LOGLEVEL = logging.WARNING
    OBJECT_ID_SUFFIX = None
    DEFAULT_INCLUDED = ""  # change to +all to include everything (slower because relationships will be fetched)
    INSTANCE_ENDPOINT_FMT = None
    INSTANCE_URL_FMT = None
    RESOURCE_URL_FMT = None
    INSTANCEMETHOD_URL_FMT = None
    CLASSMETHOD_URL_FMT = None
    RELATIONSHIP_URL_FMT = None
    ENDPOINT_FMT = None
    MAX_TABLE_COUNT = 10 ** 7  # table counts will become really slow for large tables, inform the user about it using this
    INCLUDE_ALL = "+all"  # include= url query argument that tells us to include all related resources
    #
    config = {}
    filtering_strategy = FilteringStrategy()

    def __init__(self, app, *args, **kwargs):
        """
        Constructor
        """
        self.app = app
        if app is not None:
            self.init_app(app, *args, **kwargs)

    def init_app(
        self, app, host="localhost", port=5000, prefix="", app_db=None, json_encoder=SAFRSJSONEncoder, swaggerui_blueprint=True, **kwargs
    ):
        """
        API and application initialization
        """
        if not isinstance(app, Flask):
            raise TypeError("'app' should be Flask.")

        if app_db is None:
            self.db = DB

        app.json_encoder = json_encoder
        app.request_class = SAFRSRequest
        app.response_class = SAFRSResponse
        app.url_map.strict_slashes = False

        if app.config.get("DEBUG", False):
            log.setLevel(logging.DEBUG)

        # Register the API blueprint
        if swaggerui_blueprint is True:
            swaggerui_blueprint = get_swaggerui_blueprint(
                prefix, "{}/swagger.json".format(prefix), config={"docExpansion": "none", "defaultModelsExpandDepth": -1}
            )
            app.register_blueprint(swaggerui_blueprint, url_prefix=prefix)
            swaggerui_blueprint.json_encoder = JSONEncoder

        for conf_name, conf_val in kwargs.items():
            setattr(self, conf_name, conf_val)

        for conf_name, conf_val in app.config.items():
            setattr(self, conf_name, conf_val)

        self.config.update(app.config)

        @app.before_request
        def handle_invalid_usage():
            return

        @app.before_request
        def init_ja_data():
            # ja_data holds all data[] that will be encoded
            g.ja_data = set()
            g.ja_included = set()

        # pylint: disable=unused-argument,unused-variable
        @app.teardown_appcontext
        def shutdown_session(exception=None):
            """cfr. http://flask.pocoo.org/docs/0.12/patterns/sqlalchemy/"""
            self.db.session.remove()

    @staticmethod
    def init_logging(cls, loglevel=logging.WARNING):
        """
        Specify the log format used in the webserver logs
        The webserver will catch stdout so we redirect eveything to sys.stdout
        """
        log = logging.getLogger(__name__)
        if log.level == logging.NOTSET:
            handler = logging.StreamHandler(sys.stderr)
            formatter = logging.Formatter("[%(asctime)s] %(levelname)s: %(message)s")
            handler.setFormatter(formatter)
            log.setLevel(loglevel)
            log.addHandler(handler)
        return log


def dict_merge(dct, merge_dct):
    """Recursive dict merge used for creating the swagger spec.
    Inspired by :meth:``dict.update()``, instead of updating only
    top-level keys, dict_merge recurses down into dicts nested
    to an arbitrary depth, updating keys. The ``merge_dct`` is merged into ``dct``.
    :param dct: dict onto which the merge is executed
    :param merge_dct: dct merged into dct
    :return: None
    """
    for k in merge_dct:
        if k in dct and isinstance(dct[k], dict):
            dict_merge(dct[k], merge_dct[k])
        else:
            # convert to string, for ex. http return codes
            dct[str(k)] = merge_dct[k]


def test_decorator(func):
    """Example flask-restful decorator that can be used in the "decorators" Api argument
    cfr. https://flask-restful.readthedocs.io/en/latest/api.html#id1
    """

    def api_wrapper(*args, **kwargs):
        return func(*args, **kwargs)

    if func.__name__.lower() == "get":  # pragma : no cover
        result = api_wrapper
        result.__name__ = func.__name__  # make sure to to reset the __name__ !
        return result

    return func


#
# DB and logging initialization
#
DB = SQLAlchemy()

try:
    DEBUG = os.getenv("DEBUG", logging.WARNING)
    LOGLEVEL = int(DEBUG)
except ValueError:  # pragma : no cover
    print('Invalid LogLevel in DEBUG Environment Variable! "{}"'.format(DEBUG))
    LOGLEVEL = logging.INFO

log = SAFRS.init_logging(LOGLEVEL)
