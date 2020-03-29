import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather/core/model/weather_forecast.dart';

class ApiService {
  Future<CurrentWeather> fetchCurrentWeather(int cityId) async {
    var dio = Dio();
    Response response = await dio.get(
        'http://api.openweathermap.org/data/2.5/weather?id=$cityId&APPID=05a01ea7cfe3637cb1863badd330f067');
    if (response.statusCode == 200) {
      return CurrentWeather.fromJson(json.decode(response.toString()));
    }
    return null;
  }

  Future<ForecastWeather> fetchForecastWeather(int cityId) async {
    var dio = Dio();
    Response response = await dio.get(
        'http://api.openweathermap.org/data/2.5/forecast?id=$cityId&appid=05a01ea7cfe3637cb1863badd330f067');
    if (response.statusCode == 200) {
      return ForecastWeather.fromJson(json.decode(response.toString()));
    }
    return null;
  }
}
