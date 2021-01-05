<?php

use App\Validations\OrderValidation;
use Illuminate\Http\Request;

class OrderValidationTest extends Tests\TestCase
{
    public function setUp(): void
    {
        parent::setUp();
        
        $this->faker = Faker\Factory::create();
        $this->orderValidation = $this->app->instance(
            OrderValidation::class,
            new OrderValidation()
        );

        $this->httpRequest = $this->app->instance(
            Request::class,
            new Request()
        );
    }

    public function tearDown(): void
    {
        parent::tearDown();
    }

    public function testvalidateGetOrdersMethod()
    {
        echo "\n ***** Unit Test: Valid case for Validator - Get Orders ***** \n ";
        $page = $this->faker->numberBetween(1, 9999);
        $limit = $this->faker->numberBetween(1, 9999);
        
        $params = ['page'=> $page, 'limit'=> $limit];
        $request = $this->httpRequest->merge($params);
        $response = $this->orderValidation->validateGetOrders($request);
        $this->assertTrue($response);
    }

    public function testvalidateGetOrdersMethodIncorrectParams()
    {
        echo "\n ***** Unit Test: Invalid case for Validator (negative page & limit values) - Get Orders ***** \n ";
        $page = $this->faker->numberBetween(-1, -9999);
        $limit = $this->faker->numberBetween(-1, -9999);
        
        $params = ['page'=> $page, 'limit'=> $limit];
        $request = $this->httpRequest->merge($params);
        $response = $this->orderValidation->validateGetOrders($request);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);

        echo "\n ***** Unit Test: Invalid case for Validator (0 page & limit values) - Get Orders ***** \n ";
        $page = $this->faker->numberBetween(0, 0);
        $limit = $this->faker->numberBetween(0, 0);
        
        $params = ['page'=> $page, 'limit'=> $limit];
        $request = $this->httpRequest->merge($params);
        $response = $this->orderValidation->validateGetOrders($request);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);

        echo "\n ***** Unit Test: Invalid case for Validator (non Numeric values of page & limit) - Get Orders ***** \n ";
        $page = 'ABCD';
        $limit = 'XYZ';
        
        $params = ['page'=> $page, 'limit'=> $limit];
        $request = $this->httpRequest->merge($params);
        $response = $this->orderValidation->validateGetOrders($request);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);

        echo "\n ***** Unit Test: Invalid case for Validator (blank values of page & limit) - Get Orders ***** \n ";
        $page = '';
        $limit = '';
        
        $params = ['page'=> $page, 'limit'=> $limit];
        $request = $this->httpRequest->merge($params);
        $response = $this->orderValidation->validateGetOrders($request);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
    }

    public function testvalidateCreateOrdersMethod()
    {
        echo "\n ***** Unit Test: Valid case for Validator - Create Orders ***** \n ";
        $params = [
            'origin'      => [$this->faker->latitude(), $this->faker->longitude()],
            'destination' => [$this->faker->latitude(), $this->faker->longitude()]
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $this->assertTrue($response);
    }

    public function testvalidateCreateOrdersMethodIncorrectParams()
    {
        echo "\n ***** Unit Test: Invalid case for Validator (incorrect params: origin1) - Create Orders ***** \n ";
        $params = [
            'origin1'      => [$this->faker->latitude(), $this->faker->longitude()],
            'destination' => [$this->faker->latitude(), $this->faker->longitude()]
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Unit Test: Invalid case for Validator (incorrect params: destination1) - Create Orders ***** \n ";
        $params = [
            'origin'      => [$this->faker->latitude(), $this->faker->longitude()],
            'destination1' => [$this->faker->latitude(), $this->faker->longitude()]
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Unit Test: Invalid case for Validator (incorrect params: both) - Create Orders ***** \n ";
        $params = [
            'origin1'      => [$this->faker->latitude(), $this->faker->longitude()],
            'destination1' => [$this->faker->latitude(), $this->faker->longitude()]
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Unit Test: Invalid case for Validator (min 2 origin) - Create Orders ***** \n ";
        $params = [
            'origin1'      => [$this->faker->latitude()],
            'destination1' => [$this->faker->latitude(), $this->faker->longitude()]
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Unit Test: Invalid case for Validator (min 2 destination) - Create Orders ***** \n ";
        $params = [
            'origin1'      => [$this->faker->latitude(), $this->faker->longitude()],
            'destination1' => [$this->faker->latitude()]
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Unit Test: Invalid case for Validator (min 2 both) - Create Orders ***** \n ";
        $params = [
            'origin1'      => [$this->faker->latitude()],
            'destination1' => [$this->faker->latitude()]
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Unit Test: Invalid case for Validator (max 2 origin) - Create Orders ***** \n ";
        $params = [
            'origin'      => [$this->faker->latitude(), $this->faker->longitude(), $this->faker->longitude()],
            'destination' => [$this->faker->latitude(), $this->faker->longitude()]
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Unit Test: Invalid case for Validator (max 2 destination) - Create Orders ***** \n ";
        $params = [
            'origin'      => [$this->faker->latitude(), $this->faker->longitude()],
            'destination' => [$this->faker->latitude(), $this->faker->longitude(), $this->faker->longitude()]
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Unit Test: Invalid case for Validator (max 2 both) - Create Orders ***** \n ";
        $params = [
            'origin'      => [$this->faker->latitude(), $this->faker->longitude(), $this->faker->longitude()],
            'destination' => [$this->faker->latitude(), $this->faker->longitude(), $this->faker->longitude()]
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
                
        echo "\n ***** Unit Test: Invalid case for Validator (blank origin) - Create Orders ***** \n ";
        $params = [
            'origin'      => [],
            'destination' => [$this->faker->latitude(), $this->faker->longitude(), $this->faker->longitude()]
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
                
        echo "\n ***** Unit Test: Invalid case for Validator (blank destination) - Create Orders ***** \n ";
        $params = [
            'origin'      => [$this->faker->latitude(), $this->faker->longitude(), $this->faker->longitude()],
            'destination' => []
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
                
        echo "\n ***** Unit Test: Invalid case for Validator (blank both) - Create Orders ***** \n ";
        $params = [
            'origin'      => [],
            'destination' => []
        ];
        
        $response = $this->orderValidation->validateCreateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
    }

    public function testvalidateUpdateOrdersMethod()
    {
        echo "\n ***** Unit Test: Valid case for Validator - Update Orders ***** \n ";
        $params = ['status' => 'TAKEN'];
        
        $response = $this->orderValidation->validateUpdateOrders($params);
        $this->assertTrue($response);
    }

    public function testvalidateUpdateOrdersMethodIncorrectParams()
    {
        echo "\n ***** Unit Test: Invalid case for Validator (TAKEN2) - Update Orders ***** \n ";
        $params = ['status' => 'TAKEN2'];
        
        $response = $this->orderValidation->validateUpdateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Unit Test: Invalid case for Validator (status1) - Update Orders ***** \n ";
        $params = ['status1' => 'TAKEN'];
        
        $response = $this->orderValidation->validateUpdateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Unit Test: Invalid case for Validator (blank value) - Update Orders ***** \n ";
        $params = ['status' => ''];
        
        $response = $this->orderValidation->validateUpdateOrders($params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
    }
}
