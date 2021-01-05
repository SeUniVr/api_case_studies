<?php
return [
    'status' => [
        'unassigned' => 'UNASSIGNED',
        'taken' => 'TAKEN',
        'success' => 'SUCCESS'
    ],

    'get_messages' => [
        'page.required' => 'PAGE_OR_LIMIT_IS_REQUIRED',
        'limit.required' => 'PAGE_OR_LIMIT_IS_REQUIRED',
        'page.numeric' => 'PAGE_OR_LIMIT_SHOULD_BE_NUMERIC',
        'limit.numeric' => 'PAGE_OR_LIMIT_SHOULD_BE_NUMERIC',
        'page.gt' => 'PAGE_OR_LIMIT_SHOULD_BE_GREATER_THAN_ZERO',
        'limit.gt' => 'PAGE_OR_LIMIT_SHOULD_BE_GREATER_THAN_ZERO',
        'limit_reached' => 'NO_ORDERS_ARE_PRESENT',
    ],

    'store_messages' => [
        'origin.required' => 'ORIGIN_OR_DESTINATION_IS_REQUIRED',
        'destination.required' => 'ORIGIN_OR_DESTINATION_IS_REQUIRED',
        'origin.array' => 'ORIGIN_OR_DESTINATION_SHOULD_BE_AN_ARRAY',
        'destination.array' => 'ORIGIN_OR_DESTINATION_SHOULD_BE_AN_ARRAY',
        'origin.min' => 'ORIGIN_OR_DESTINATION_SHOULD_HAVE_MINIMUM_TWO_VALUES',
        'destination.min' => 'ORIGIN_OR_DESTINATION_SHOULD_HAVE_MINIMUM_TWO_VALUES',
        'origin.max' => 'ORIGIN_OR_DESTINATION_SHOULD_HAVE_MAXIMUM_TWO_VALUES',
        'destination.max' => 'ORIGIN_OR_DESTINATION_SHOULD_HAVE_MAXIMUM_TWO_VALUES',
        'origin.validatelatlong' => 'ORIGIN_OR_DESTINATION_COORDINATE_SHOULD_BE_CORRECT',
        'destination.validatelatlong' => 'ORIGIN_OR_DESTINATION_COORDINATE_SHOULD_BE_CORRECT',
        'ordererror' => 'ORDER_NOT_CREATED_TRY_AGAIN',
        'badrequest' => 'BAD_REQUEST',
        'samesourcedest' => 'SAME_SOURCE_DESTINATION',
    ],

    'update_messages' => [
        'status.required' => 'STATUS_IS_REQUIRED',
        'status.in' => 'INVALID_STATUS',
        'taken' => 'ORDER_ALREADY_TAKEN',
        'incorrect' => 'STATUS_OR_ORDER_ID_IS_INCORRECT',
        'incorrectorderid' => 'ORDER_ID_IS_INCORRECT',
        'incorrectparameters' => 'INCORRECT_PARAMETERS_PASSED',
    ],
];
