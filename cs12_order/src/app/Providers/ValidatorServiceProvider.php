<?php namespace App\Providers;

use Illuminate\Support\ServiceProvider;

class ValidatorServiceProvider extends ServiceProvider
{
    public function boot()
    {
        $this->app['validator']->extend('validatelatlong', function ($attribute, $value, $parameters) {
            $latitude = $value[0];
            $longitude = $value[1];

            if (!$latitude || !$longitude) {
                $error = 'REQUEST_PARAMETER_MISSING';
            } elseif ($latitude < -90 || $latitude > 90) {
                $error = 'LATITUDE_OUT_OF_RANGE';
            } elseif ($longitude < -180 || $longitude > 180) {
                $error = 'LONGITUDE_OUT_OF_RANGE';
            } elseif (!is_numeric($latitude) || !is_numeric($longitude)) {
                $error = 'INVALID_PARAMETERS';
            }

            if (empty($error)) {
                return true;
            } else {
                return false;
            }
        });
    }
}
