import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather/core/model/forecast_weather.dart';

class ApiService {
  Future<ForecastWeather> fetchForecastWeather(int cityId) async {
    var dio = Dio();
    Response response =
        await dio.get('https://www.metaweather.com/api/location/$cityId');
    if (response.statusCode == 200) {
      return ForecastWeather.fromJson(json.decode(response.toString()));
    }
    return null;
  }
}
