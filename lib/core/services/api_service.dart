import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/core/model/forecast_weather.dart';

class ApiService {
  Future<ForecastWeather> fetchForecastWeather(int cityId) async {
    fetchCitiesLike('delhi');
    var dio = Dio();
    Response response =
        await dio.get('https://www.metaweather.com/api/location/$cityId');
    if (response.statusCode == 200) {
      return ForecastWeather.fromJson(json.decode(response.toString()));
    }
    return null;
  }

  Future<List<City>> fetchCitiesLike(String pattern) async {
    if (pattern.isEmpty) {
      return [];
    }
    var dio = Dio();
    Response response = await dio
        .get('https://www.metaweather.com/api/location/search/?query=$pattern');
    if (response.statusCode == 200) {
      return List.generate(response.data.length, (i) {
        return City.fromJson(response.data[i]);
      });
    }
    return [];
  }
}
