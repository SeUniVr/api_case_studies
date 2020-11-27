<?php

namespace App\Model;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class OrderModel extends Model
{
    public function getOrders($limit, $page)
    {
        $skip = $limit * ($page - 1);
        $orders = DB::table('orders')->select('id', 'distance', 'status')->skip($skip)->limit($limit)->get();

        if (count($orders) > 0) {
            $allorder = array();
            foreach ($orders as $data) {
                $singleOrder = array(
                    'id' => $data->id,
                    'distance' => $data->distance,
                    'status' => $data->status
                );
                array_push($allorder, $singleOrder);
            }
            
            return Response($allorder, 200);
        } else {
            return Response([], 200);
        }
    }

    public function createOrder($response, $orderData)
    {
        if ($response->rows[0]->elements[0]->status == 'OK' && $response->status == 'OK') {
            $distance = $response->rows[0]->elements[0]->distance->value;

            $order = DB::table('orders')->insertGetId([
                'origin' => json_encode($orderData['origin']),
                'destination' => json_encode($orderData['destination']),
                'distance' => $distance,
                'status' => config('orders.status')['unassigned'],
            ]);

            $responseArr = array(
                'id' => $order,
                'distance' => $distance,
                'status' => config('orders.status')['unassigned']
            );
            
            return json_encode($responseArr);
        } else {
            return Response(["error" => config('orders.store_messages')['badrequest']], 400);
        }
    }

    public function updateOrder($taken_status, $order_id)
    {
        if (!empty($taken_status) && $taken_status == config('orders.status')['taken'] && !empty($order_id) && $order_id > 0) {
            $check_order_exist = DB::table('orders')->where('id', $order_id)->get();
            
            if (sizeof($check_order_exist)) {
                $order = DB::table('orders')->where([
                    ['id','=',$order_id],
                    ['status','=', config('orders.status')['unassigned']]
                ])->update(['status' => $taken_status]);

                if ($order) {
                    return Response(["status" => config('orders.status')['success']], 200);
                } else {
                    return Response(["error" => config('orders.update_messages')['taken']], 409);
                }
            } else {
                return Response(["error" => config('orders.update_messages')['incorrectorderid']], 404);
            }
        } else {
            return Response(["error" => config('orders.update_messages')['incorrect']], 400);
        }
    }
}
