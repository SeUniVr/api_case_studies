FROM python:3.8

WORKDIR /app

COPY . .

RUN pip install .

ENTRYPOINT python3 examples/demo_relationship.py "0.0.0.0"