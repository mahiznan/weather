import 'package:flutter/material.dart';
import 'package:weather/core/model/forecast_weather.dart';
import 'package:weather/core/services/api_service.dart';

class WeatherProvider with ChangeNotifier {
  ForecastWeather _forecastWeather;
  int _activeIndex;

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
      _activeIndex = 0;
      busy(false);
    });
  }

  set activeWeather(int index) {
    busy(true);
    _activeIndex = index;
    busy(false);
  }

  void busy(bool v) {
    _loading = v;
    notifyListeners();
  }

  get forecastWeather => _forecastWeather;
  get activeIndex => _activeIndex;
  get loading => _loading;
}
