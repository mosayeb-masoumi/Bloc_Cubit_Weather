import 'dart:math';

import 'package:weather_cubit/data/model/weather.dart';

abstract class WeatherRepository{

  Future<Weather> fetchWeather(String cityName);
  // Future<Weather> fetchWeather(String cityName);
}

class FakeWeatherRepository extends WeatherRepository{
  @override
  Future<Weather> fetchWeather(String cityName) {

    // request to server and return data
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
          () {
        final random = Random();

        // Simulate some network exception
        if (random.nextBool()) {
          throw NetworkException();
        }

        // Return "fetched" weather
        return Weather(
          cityName: cityName,
          // Temperature between 20 and 35.99
          temperatureCelsius: 20 + random.nextInt(15) + random.nextDouble(),
        );
      },
    );
  }
}

class NetworkException implements Exception {}
