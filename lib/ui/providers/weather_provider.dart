import 'package:flutter/material.dart';
import 'package:weather/core/model/forecast_weather.dart';
import 'package:weather/core/services/api_service.dart';

class WeatherProvider with ChangeNotifier {
  ForecastWeather _forecastWeather;

  bool _loading = true;
  ApiService apiService;
  WeatherProvider() {
    apiService = ApiService();
    fetchForecastWeather(1062617);
  }

  void fetchForecastWeather(int cityId) async {
    busy(true);
    apiService.fetchForecastWeather(cityId).then((weather) {
      _forecastWeather = weather;
      busy(false);
    });
  }

  void busy(bool v) {
    _loading = v;
    notifyListeners();
  }

  get forecastWeather => _forecastWeather;
  get loading => _loading;
}
