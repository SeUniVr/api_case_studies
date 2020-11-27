<?php

use App\Http\Controllers\OrderController;
use App\Model\OrderModel;
use App\Services\DistanceService;
use App\Validations\OrderValidation;
use Illuminate\Foundation\Testing\WithoutMiddleware;

class OrderControllerTest extends Tests\TestCase
{
    use WithoutMiddleware;
    
    protected static $orderStatus = [
        'UNASSIGNED',
        'TAKEN',
    ];

    public function setUp(): void
    {
        parent::setUp();
        $this->distanceServiceMock = \Mockery::mock(\App\Services\DistanceService::class);
        $this->orderModelMock = \Mockery::mock(\App\Model\OrderModel::class);
        $this->orderValidationMock = \Mockery::mock(\App\Validations\OrderValidation::class);
        $this->faker = Faker\Factory::create();
        $this->app->instance(
            OrderController::class,
            new OrderController(
                $this->distanceServiceMock,
                $this->orderModelMock,
                $this->orderValidationMock
            )
        );
    }

    public function tearDown(): void
    {
        parent::tearDown();
        \Mockery::close();
    }

    public function testListControllerMethod()
    {
        echo "\n ***** Unit Test: Valid case for Controller - Get Orders ***** \n ";
        $this->orderValidationMock
            ->shouldReceive('validateGetOrders')
            ->once()
            ->andReturn(true);
        
        $this->orderModelMock
            ->shouldReceive('getOrders')
            ->once()
            ->andReturn('[{"id":4,"distance":"854523","status":"TAKEN"},{"id":5,"distance":"854523","status":"TAKEN"},{"id":6,"distance":"854523","status":"TAKEN"}]');
        
        $inputParams = 'page=1&limit=3';
        $response = $this->call('GET', '/orders?'.$inputParams);
        $resData = json_decode($response->baseResponse->original, true);
        $response->assertStatus(200);

        foreach ($resData as $order) {
            $this->assertInternalType('array', $order);
            $this->assertArrayHasKey('id', $order);
            $this->assertArrayHasKey('distance', $order);
            $this->assertArrayHasKey('status', $order);
        }

        echo "\n ***** Unit Test: Valid case for Controller - Get Orders with page=0 and limit=0 ***** \n ";
        $this->orderValidationMock
            ->shouldReceive('validateGetOrders')
            ->once()
            ->andReturn(["error" => 'page & limit must be greater than 0']);
        
        $inputParams = 'page=0&limit=0';
        $response = $this->call('GET', '/orders?'.$inputParams);
        $resData = $response->baseResponse->original;
        $response->assertStatus(406);
        $this->assertArrayHasKey('error', $resData);
    }

    public function testCreateControllerMethod()
    {
        echo "\n ***** Unit Test: Valid case for Controller - Create Order ***** \n ";
        $orderRes = array(
            "id"=> $this->faker->numberBetween(1, 999),
            "distance"=> $this->faker->numberBetween(1, 999999),
            "status"=> "UNASSIGNED"
        );

        $disRes = json_decode('{"destination_addresses":["E Glide Rd, Melbourne Airport VIC 3045, Australia"],"origin_addresses":["12 O\'Connell St, Sydney NSW 2000, Australia"],"rows":[{"elements":[{"distance":{"text":"855 km","value":854523},"duration":{"text":"8 hours 23 mins","value":30161},"status":"OK"}]}],"status":"OK"}');
        
        $inputParams = [
            'origin' => [$this->faker->latitude(), $this->faker->longitude()],
            'destination' => [$this->faker->latitude(), $this->faker->longitude()]
        ];

        $this->orderValidationMock
            ->shouldReceive('validateCreateOrders')
            ->once()
            ->andReturn(true);
        
        $this->distanceServiceMock
            ->shouldReceive('calculate_distance')
            ->once()
            ->andReturn($disRes);
        
        $this->orderModelMock
            ->shouldReceive('createOrder')
            ->once()
            ->andReturn($orderRes);
        
        $response = $this->call('POST', '/orders', $inputParams);
        $resData = (array) $response->baseResponse->original;
        $response->assertStatus(200);
        
        $this->assertInternalType('array', $resData);
        $this->assertArrayHasKey('id', $resData);
        $this->assertArrayHasKey('distance', $resData);
    }

    public function testUpdateControllerMethod()
    {
        echo "\n ***** Unit Test: Valid case for Controller - Update Order ***** \n ";
        $order_id = '1';
        $inputParams = ["status" => "TAKEN"];

        $this->orderValidationMock
            ->shouldReceive('validateUpdateOrders')
            ->once()
            ->andReturn(true);
        
        $this->orderModelMock
            ->shouldReceive('updateOrder')
            ->once()
            ->andReturn('{"status":"SUCCESS"}');
        
        $response = $this->json('PATCH', '/orders/'.$order_id, $inputParams);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $resData = json_decode($response->baseResponse->original, true);
        $response->assertStatus(200);
        
        $this->assertArrayHasKey('status', $resData);
        $this->assertEquals($resData['status'], 'SUCCESS');
    }
}
