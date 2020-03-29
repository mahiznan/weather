import 'package:flutter/material.dart';
import 'package:weather/core/model/weather_forecast.dart';
import 'package:weather/core/services/api_service.dart';

class WeatherProvider with ChangeNotifier {
  CurrentWeather _currentWeather;
  ForecastWeather _forecastWeather;

  bool _loading = true;
  ApiService apiService;
  WeatherProvider() {
    apiService = ApiService();
    fetchCurrentWeather(1273293);
    fetchForecastWeather(1273293);
  }

  void fetchCurrentWeather(int cityId) async {
    busy(true);
    apiService.fetchCurrentWeather(cityId).then((weather) {
      _currentWeather = weather;
      busy(false);
    });
  }

  void fetchForecastWeather(int cityId) {
    busy(true);
    apiService.fetchForecastWeather(cityId).then((forecastWeather) {
      _forecastWeather = forecastWeather;
      List<Forecast> forecast = List<Forecast>();
      DateTime dt = forecastWeather.list[0].dtTxt;
      for (int i = 1; i < forecastWeather.list.length; i++) {
        if ((forecastWeather.list[i].dtTxt).difference(dt).inHours > 21) {
          forecast.add(forecastWeather.list[i]);
          dt = forecastWeather.list[i].dtTxt;
        }
      }
      forecastWeather.list = forecast;
      busy(false);
    });
  }

  void busy(bool v) {
    _loading = v;
    notifyListeners();
  }

  get currentWeather => _currentWeather;
  get forecastWeather => _forecastWeather;
  get loading => _loading;
}
