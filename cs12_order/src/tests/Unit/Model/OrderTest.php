<?php

use Tests\TestCase;
use App\Model\OrderModel;

class OrderTest extends TestCase
{
    protected static $orderStatus = [
        'UNASSIGNED',
        'TAKEN',
    ];

    public function setUp(): void
    {
        parent::setUp();
        $this->faker = Faker\Factory::create();
        $this->orderModel = $this->app->instance(
            OrderModel::class,
            new OrderModel()
        );
    }
    
    public function tearDown(): void
    {
        parent::tearDown();
    }

    public function testGetOrdersMethod()
    {
        echo "\n ***** Unit Test: Valid Unit test case for Model - Get Orders ***** \n ";
        $orderData = [
            'origin' => [$this->faker->latitude(), $this->faker->longitude()],
            'destination' => [$this->faker->latitude(), $this->faker->longitude()]
        ];

        $googleResponse = json_decode('{"destination_addresses":["E Glide Rd, Melbourne Airport VIC 3045, Australia"],"origin_addresses":["12 O\'Connell St, Sydney NSW 2000, Australia"],"rows":[{"elements":[{"distance":{"text":"855 km","value":854523},"duration":{"text":"8 hours 23 mins","value":30161},"status":"OK"}]}],"status":"OK"}');

        $resdata = $this->orderModel->createOrder($googleResponse, $orderData);
        $resdata = $this->orderModel->createOrder($googleResponse, $orderData);
        $resdata = $this->orderModel->createOrder($googleResponse, $orderData);
        $order = json_decode($resdata, true);

        $page = '1';
        $limit = '3';
        $resdata1 = $this->orderModel->getOrders($limit, $page);
        $data = json_decode($resdata1->getContent(), true);

        foreach ($data as $order) {
            $this->assertArrayHasKey('id', $order);
            $this->assertArrayHasKey('distance', $order);
            $this->assertArrayHasKey('status', $order);
        }
    }

    public function testCreateOrdersMethod()
    {
        echo "\n ***** Unit Test: Valid Unit test case for Model - Create Order ***** \n ";
        $orderData = [
            'origin' => [$this->faker->latitude(), $this->faker->longitude()],
            'destination' => [$this->faker->latitude(), $this->faker->longitude()]
        ];

        $googleResponse = json_decode('{"destination_addresses":["E Glide Rd, Melbourne Airport VIC 3045, Australia"],"origin_addresses":["12 O\'Connell St, Sydney NSW 2000, Australia"],"rows":[{"elements":[{"distance":{"text":"855 km","value":854523},"duration":{"text":"8 hours 23 mins","value":30161},"status":"OK"}]}],"status":"OK"}');

        $resdata = $this->orderModel->createOrder($googleResponse, $orderData);
        $order = json_decode($resdata, true);

        $this->assertArrayHasKey('id', $order);
        $this->assertArrayHasKey('distance', $order);
        $this->assertArrayHasKey('status', $order);

        echo "\n ***** Unit Test: Invalid Unit test case for Model - Create Order - if Status = NO ***** \n ";
        $googleResponse = json_decode('{"destination_addresses":["E Glide Rd, Melbourne Airport VIC 3045, Australia"],"origin_addresses":["12 O\'Connell St, Sydney NSW 2000, Australia"],"rows":[{"elements":[{"distance":{"text":"855 km","value":854523},"duration":{"text":"8 hours 23 mins","value":30161},"status":"NO"}]}],"status":"NO"}');

        $resdata = $this->orderModel->createOrder($googleResponse, $orderData);
        $order = json_decode($resdata->getContent(), true);

        $this->assertArrayHasKey('error', $order);
    }

    public function testUpdateOrderMethod()
    {
        echo "\n ***** Unit Test: Valid Unit test case for Model - Update Order ***** \n ";
        $orderData = [
            'origin' => [$this->faker->latitude(), $this->faker->longitude()],
            'destination' => [$this->faker->latitude(), $this->faker->longitude()]
        ];

        $googleResponse = json_decode('{"destination_addresses":["E Glide Rd, Melbourne Airport VIC 3045, Australia"],"origin_addresses":["12 O\'Connell St, Sydney NSW 2000, Australia"],"rows":[{"elements":[{"distance":{"text":"855 km","value":854523},"duration":{"text":"8 hours 23 mins","value":30161},"status":"OK"}]}],"status":"OK"}');

        $resdata = $this->orderModel->createOrder($googleResponse, $orderData);
        $order = json_decode($resdata, true);

        $order_id = $order['id'];

        $resdata = $this->orderModel->updateOrder(config('orders.status')['taken'], $order_id);
        $data = json_decode($resdata->getContent(), true);

        $this->assertArrayHasKey('status', $data);
        $this->assertEquals($data['status'], 'SUCCESS');

        echo "\n ***** Unit Test: Invalid Unit test case for Model - Update Order: Taken ***** \n ";
        $resdata = $this->orderModel->updateOrder(config('orders.status')['taken'], $order_id);
        $data = json_decode($resdata->getContent(), true);

        $this->assertArrayHasKey('error', $data);
        $this->assertEquals($data['error'], 'ORDER_ALREADY_TAKEN');
    }
}
