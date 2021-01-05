<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use App\Services\DistanceService;
use App\Providers\ValidatorServiceProvider;
use App\Model\OrderModel;
use App\Validations\OrderValidation;
use App\Order;

class OrderController extends Controller
{
    protected $cd;

    public function __construct(DistanceService $cd, OrderModel $orderModel, OrderValidation $orderValidation)
    {
        $this->cal_distance = $cd;
        $this->orderModel = $orderModel;
        $this->orderValidation = $orderValidation;
    }

    public function list(Request $request)
    {
        try {
            $validOrder = $this->orderValidation->validateGetOrders($request);

            if (empty($validOrder->original)) {
                if (!empty($request->limit) && $request->limit > 0 && !empty($request->page) && $request->page > 0) {
                    $data = $this->orderModel->getOrders($request->limit, $request->page);
                    return $data;
                } else {
                    return Response($validOrder, 406);
                }
            } else {
                return Response($validOrder->original, 406);
            }
        } catch (\Exception $ex) {
            return Response(["error" => $ex->getMessage()], 503);
        }
    }

    public function create(Request $request)
    {
        try {
            $data = json_decode($request->getContent(), true);
            
            $validOrder = $this->orderValidation->validateCreateOrders($data);

            if (empty($validOrder->original)) {
                $final_data = $this->cal_distance->calculate_distance($data);

                if ($final_data->rows[0]->elements[0]->status == 'OK' && $final_data->status == 'OK') {
                    return $this->orderModel->createOrder($final_data, $data);
                } else {
                    return Response(["error" => config('orders.store_messages')['badrequest']], 400);
                }
            } else {
                return Response($validOrder->original, 400);
            }
            
            return Response($final_data, 200);
        } catch (\Exception $ex) {
            return Response(["error" => $ex->getMessage()], 400);
        }
    }

    public function update(Request $request, $order_id)
    {
        try {
            $data = json_decode($request->getContent(), true);
            $validOrder = $this->orderValidation->validateUpdateOrders($data);

            if (empty($validOrder->original)) {
                if (count($data) === 1) {
                    $update_order = $this->orderModel->updateOrder($data['status'], $order_id);
                    return $update_order;
                } else {
                    return Response(["error" => config('orders.update_messages')['incorrectparameters']], 400);
                }
            } else {
                return Response($validOrder->original, 400);
            }
        } catch (\Exception $ex) {
            return Response(["error" => $ex->getMessage()], 503);
        }
    }
}
