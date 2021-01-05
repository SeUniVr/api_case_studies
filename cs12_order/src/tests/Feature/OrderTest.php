<?php

namespace Tests\Feature;

use Tests\TestCase;
use Illuminate\Foundation\Testing\WithFaker;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\JsonResponse;

class OrderTest extends TestCase
{
    /**
     * A basic feature test example.
     *
     * @return void
     */
    
    public function testGetOrdersWithCorrectParams()
    {
        echo "\n ***** Valid test - param value (page=4 and limit=2) - should get 200 ***** \n ";
        $params = '{"origin": ["-33.865143","151.209900"], "destination": ["-37.663712","144.844788"]}';
        $params = json_decode($params, true);
        $response = $this->json('POST', '/orders', $params);
        
        $params = '{"origin": ["-33.865143","151.209900"], "destination": ["-37.663712","144.844788"]}';
        $params = json_decode($params, true);
        $response = $this->json('POST', '/orders', $params);
        
        $params = 'page=1&limit=2';
        $response = $this->json('GET', '/orders?'.$params);
        $response_data = $response->getContent();
        $response->assertStatus(200);

        echo "\n ***** Valid test - Number or count of response should be less than 2 - should get 200 ***** \n ";
        $this->assertLessThan(3, count($response_data));
        
        echo "\n ***** Valid test - Get Order - Response should contain id, distance and status keys only ***** \n";
        $response_data = json_decode($response_data);

        foreach ($response_data as $order) {
            $order = (array) $order;
            $this->assertArrayHasKey('id', $order);
            $this->assertArrayHasKey('distance', $order);
            $this->assertArrayHasKey('status', $order);
        }
    }
    
    public function testGetOrdersWithInCorrectParams()
    {
        echo "\n ***** Invalid test - param value (page=-2) - should get 406 ***** \n ";
        $params = 'page=-2&limit=4';
        $response = $this->json('GET', '/orders?$params');
        $response_data = $response->getContent();
        $response->assertStatus(406);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);

        echo "\n ***** Invalid test - param value (limit=-2) - should get 406 ***** \n ";
        $params = 'page=2&limit=-2';
        $response = $this->json('GET', '/orders?$params');
        $response_data = $response->getContent();
        $response->assertStatus(406);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);

        echo "\n ***** Invalid test - param value (limit=-1 and page=-2) - should get 406 ***** \n ";
        $params = 'page=-2&limit=-1';
        $response = $this->json('GET', '/orders?$params');
        $response_data = $response->getContent();
        $response->assertStatus(406);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);

        echo "\n ***** Invalid test - param value (page=0) - should get 406 ***** \n ";
        $params = 'page=0&limit=1';
        $response = $this->json('GET', '/orders?$params');
        $response_data = $response->getContent();
        $response->assertStatus(406);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);

        echo "\n ***** Invalid test - param value (limit=0) - should get 406 ***** \n ";
        $params = 'page=1&limit=0';
        $response = $this->json('GET', '/orders?$params');
        $response_data = $response->getContent();
        $response->assertStatus(406);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);

        echo "\n ***** Invalid test - param value (page=0 and limit=0) - should get 406 ***** \n ";
        $params = 'page=0&limit=0';
        $response = $this->json('GET', '/orders?$params');
        $response_data = $response->getContent();
        $response->assertStatus(406);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);

        echo "\n ***** Invalid test - param value (page1=1) - should get 406 ***** \n ";
        $params = 'page1=1&limit=3';
        $response = $this->json('GET', '/orders?$params');
        $response_data = $response->getContent();
        $response->assertStatus(406);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - param value (limit1=3) - should get 406 ***** \n ";
        $params = 'page=1&limit1=3';
        $response = $this->json('GET', '/orders?$params');
        $response_data = $response->getContent();
        $response->assertStatus(406);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - param value (extra=2) - should get 406 ***** \n ";
        $params = 'page1=1&limit=3&extra=2';
        $response = $this->json('GET', '/orders?$params');
        $response_data = $response->getContent();
        $response->assertStatus(406);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - No param value - should get 406 ***** \n ";
        $params = '';
        $response = $this->json('GET', '/orders?$params');
        $response_data = $response->getContent();
        $response->assertStatus(406);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
    }

    public function testPostOrderSucess()
    {
        echo "\n ***** Valid test - Post Order - should get 200 ***** \n ";
        $params = '{"origin": ["-33.865143","151.209900"], "destination": ["-37.663712","144.844788"]}';
        $params = json_decode($params, true);
        $response = $this->json('POST', '/orders', $params);
        $response_data = $response->getContent();
        $response->assertStatus(200);
        $response_data = (array) json_decode($response_data);

        echo "\n ***** Valid test - Post Order - Response should contain id, distance and status keys only ***** \n";
        $this->assertArrayHasKey('id', $response_data);
        $this->assertArrayHasKey('status', $response_data);
        $this->assertArrayHasKey('distance', $response_data);
    }

    public function testPostOrderWithInCorrectParams()
    {
        echo "\n ***** Invalid test - param values (more than 2 keys in origin) - should get 400 ***** \n ";
        $params = '{"origin": ["-33.865143","151.209900", "1.56789"], "destination": ["-37.663712","144.844788"]}';
        $params = json_decode($params, true);
        $response = $this->json('POST', '/orders', $params);
        $response_data = $response->getContent();
        $response->assertStatus(400);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);

        echo "\n ***** Invalid test - param values (more than 2 keys in both) - should get 400 ***** \n ";
        $params = '{"origin": ["-33.865143","151.209900", "1.56789"], "destination": ["-37.663712","144.844788", "1.56789"]}';
        $params = json_decode($params, true);
        $response = $this->json('POST', '/orders', $params);
        $response_data = $response->getContent();
        $response->assertStatus(400);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);

        echo "\n ***** Invalid test - param keys (origin1) - should get 400 ***** \n ";
        $params = '{"origin1": ["-33.865143","151.209900"], "destination": ["-37.663712","144.844788"]}';
        $params = json_decode($params, true);
        $response = $this->json('POST', '/orders', $params);
        $response_data = $response->getContent();
        $response->assertStatus(400);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - param keys (destination1) - should get 400 ***** \n ";
        $params = '{"origin": ["-33.865143","151.209900"], "destination1": ["-37.663712","144.844788"]}';
        $params = json_decode($params, true);
        $response = $this->json('POST', '/orders', $params);
        $response_data = $response->getContent();
        $response->assertStatus(400);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - param values (0) - should get 400 ***** \n ";
        $params = '{"origin": ["0","0"], "destination": ["0","0"]}';
        $params = json_decode($params, true);
        $response = $this->json('POST', '/orders', $params);
        $response_data = $response->getContent();
        $response->assertStatus(400);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - empty param values - should get 400 ***** \n ";
        $params = '{"origin": ["-33.865143",""], "destination": ["","144.844788"]}';
        $params = json_decode($params, true);
        $response = $this->json('POST', '/orders', $params);
        $response_data = $response->getContent();
        $response->assertStatus(400);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
    }

    public function testUpdateStatus()
    {
        echo "\n ***** Valid test - Update Order - should get 200 ***** \n ";
        // Creating test order
        $params1 = '{"origin": ["-33.865143","151.209900"], "destination": ["-37.663712","144.844788"]}';
        $params1 = json_decode($params1, true);
        $response1 = $this->json('POST', '/orders', $params1);
        $res = $response1->getContent();
        $res = (array) json_decode($res);
        
        $params = '{"status": "TAKEN"}';
        $params = json_decode($params, true);
        $query = "/".$res['id'];
        $response = $this->json('PATCH', '/orders'.$query, $params);
        $response_data = $response->getContent();
        $response_data = (array) json_decode($response_data);
        $response->assertStatus(200);
        
        echo "\n ***** Valid test - Update Order - Response should status key only ***** \n";
        $this->assertArrayHasKey('status', $response_data);
    }

    public function testUpdateStatusWithIncorrectParams()
    {
        echo "\n ***** InValid test - Updating Order which is already taken - should get 409 ***** \n ";
        // Creating test order
        $params1 = '{"origin": ["-33.865143","151.209900"], "destination": ["-37.663712","144.844788"]}';
        $params1 = json_decode($params1, true);
        $response1 = $this->json('POST', '/orders', $params1);
        $res = $response1->getContent();
        $res = (array) json_decode($res);

        $params2 = '{"status": "TAKEN"}';
        $params2 = json_decode($params2, true);
        $query2 = "/".$res['id'];
        $response2 = $this->json('PATCH', '/orders'.$query2, $params2);
        $response_data2 = $response2->getContent();
        $response_data2 = (array) json_decode($response_data2);

        $params = '{"status": "TAKEN"}';
        $params = json_decode($params, true);
        $query = "/".$res['id'];
        $response = $this->json('PATCH', '/orders'.$query, $params);
        $response_data = $response->getContent();
        $response->assertStatus(409);
        $response_data = (array) json_decode($response_data);

        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - param keys (stutas) - should get 400 ***** \n ";
        $params = '{"stutas": "TAKEN"}';
        $params = json_decode($params, true);
        $query = "/10";
        $response = $this->json('PATCH', '/orders'.$query, $params);
        $response_data = $response->getContent();
        $response->assertStatus(400);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - blank param - should get 400 ***** \n ";
        $params = [''];
        $query = "/10";
        $response = $this->json('PATCH', '/orders'.$query, $params);
        $response_data = $response->getContent();
        $response->assertStatus(400);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - extra params - should get 400 ***** \n ";
        $params = '{"status": "TAKEN", "extra": "ABCD"}';
        $params = json_decode($params, true);
        $query = "/10";
        $response = $this->json('PATCH', '/orders'.$query, $params);
        $response_data = $response->getContent();
        $response->assertStatus(400);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - params value (TAKEN2) - should get 400 ***** \n ";
        $params = '{"status": "TAKEN2"}';
        $params = json_decode($params, true);
        $query = "/10";
        $response = $this->json('PATCH', '/orders'.$query, $params);
        $response_data = $response->getContent();
        $response->assertStatus(400);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - params order id (ABC) - should get 400 ***** \n ";
        $params = '{"status": "TAKEN"}';
        $params = json_decode($params, true);
        $query = "/ABC";
        $response = $this->json('PATCH', '/orders'.$query, $params);
        $response_data = $response->getContent();
        $response->assertStatus(400);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
        
        echo "\n ***** Invalid test - Incorrect order id (7000) - should get 404 ***** \n ";
        $params = '{"status": "TAKEN"}';
        $params = json_decode($params, true);
        $query = "/7000";
        $response = $this->json('PATCH', '/orders'.$query, $params);
        $response_data = $response->getContent();
        $response->assertStatus(404);
        $response_data = (array) json_decode($response_data);
        $this->assertArrayHasKey('error', $response_data);
    }
}
