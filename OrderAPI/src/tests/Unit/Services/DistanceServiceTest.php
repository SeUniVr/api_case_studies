<?php

use \GuzzleHttp\Client as HttpClient;
use \GuzzleHttp\Psr7\Response;
use \GuzzleHttp\Psr7;
use App\Model\OrderModel;
use App\Services\DistanceService;

class DistanceServiceTest extends Tests\TestCase
{
    public function setUp(): void
    {
        parent::setUp();
        
        $this->httpClientMock = \Mockery::mock(HttpClient::class);
        $this->orderModelMock = \Mockery::mock(\App\Model\OrderModel::class);
        $this->faker            = Faker\Factory::create();

        $this->distanceService = $this->app->instance(
            DistanceService::class,
            new DistanceService(
                $this->orderModelMock,
                $this->httpClientMock
            )
        );
    }

    public function tearDown(): void
    {
        parent::tearDown();
        \Mockery::close();
    }

    public function testCalculateDistanceMethod()
    {
        echo "\n ***** Unit Test: Valid case for Distance Service - Get Distance ***** \n ";
        $params = [
            'origin' => [$this->faker->latitude(), $this->faker->longitude()],
            'destination' => [$this->faker->latitude(), $this->faker->longitude()]
        ];

        $response = $this->getGuzzleResponseDummy();

        $this->httpClientMock
            ->shouldReceive('get')
            ->once()
            ->andReturn($response);
        
        $response = $this->distanceService->calculate_distance($params);
        $distance = $response->rows[0]->elements[0]->distance->value;
        $this->assertIsInt($distance);
    }

    public function testCalculateDistanceMethodIncorrect()
    {
        echo "\n ***** Unit Test: Invalid case for Distance Service (Response NOT OK) - Get Distance ***** \n ";
        $params = [
            'origin' => [$this->faker->latitude(), $this->faker->longitude()],
            'destination' => [$this->faker->latitude(), $this->faker->longitude()]
        ];

        $response = $this->getGuzzleWrongResponseDummy();

        $this->httpClientMock
            ->shouldReceive('get')
            ->once()
            ->andReturn($response);
        
        $response = $this->distanceService->calculate_distance($params);
        $status = $response->rows[0]->elements[0]->status;
        $this->assertNotEquals($status, 'OK');
    }

    public function getGuzzleResponseDummy()
    {
        $stream = Psr7\stream_for('{"destination_addresses":[" E Glide Rd, Melbourne Airport VIC 3045, Australia"],"origin_addresses":["12 O\'Connell St, Sydney NSW 2000, Australia"],"rows":[{"elements":[{"distance":{"text":"855 km","value":854523},"duration":{"text":"8 hours 23 mins","value":30154},"status":"OK"}]}],"status":"OK"}');
    
        $response = new Response(200, ['Content-Type' => 'application/json'], $stream);
        return $response;
    }

    public function getGuzzleWrongResponseDummy()
    {
        $stream = Psr7\stream_for('{"destination_addresses":["37.663712,144.844788"],"origin_addresses":["-33.865143,151.2099"],"rows":[{"elements":[{"status":"ZERO_RESULTS"}]}],"status":"OK"}');
    
        $response = new Response(200, ['Content-Type' => 'application/json'], $stream);
        return $response;
    }
}
