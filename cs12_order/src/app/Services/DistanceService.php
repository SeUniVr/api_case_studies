<?php

namespace App\Services;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use App\Model\OrderModel;
use GuzzleHttp\Client;
use App\Order;

class DistanceService
{
    protected $client;

    public function __construct(OrderModel $orderModel, Client $client)
    {
        $this->orderModel = $orderModel;
        $this->client = $client;
    }

    public function calculate_distance($orderData)
    {
        try {
            $googleApiKey = env('GOOGLE_API_KEY');
            $googleApiUrl = env('GOOGLE_API_URL');
            $googleApiUnit = env('GOOGLE_API_UNIT');
            
            //$routeURL = $googleApiUrl.'units='.$googleApiUnit.'&origins='.$orderData['origin'][0].','.$orderData['origin'][1].'&destinations='.$orderData['destination'][0].','.$orderData['destination'][1].'&key='.$googleApiKey;

            $routeURL = $googleApiUrl;
            $routeURL .= 'units='.$googleApiUnit;
            $routeURL .= '&origins='.$orderData['origin'][0].','.$orderData['origin'][1];
            $routeURL .= '&destinations='.$orderData['destination'][0].','.$orderData['destination'][1];
            $routeURL .= '&key='.$googleApiKey;

            $request = $this->client->get($routeURL);
            
            $response = json_decode($request->getBody());

            return $response;
        } catch (\Exception $ex) {
            return Response(["error" => $ex->getMessage()], 400);
        }
    }
}
