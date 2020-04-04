import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/core/model/forecast_weather.dart';
import 'package:weather/ui/helper.dart';
import 'package:weather/ui/providers/weather_provider.dart';
import 'package:weather/ui/widgets/weather_detail_widget.dart';
import 'package:weather/ui/widgets/weather_widget.dart';
import 'package:weather/ui/widgets/wind_widget.dart';

class DebugScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(65, 151, 199, 1),
                Color.fromRGBO(13, 53, 147, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Consumer<WeatherProvider>(builder: (BuildContext context,
              WeatherProvider weatherProvider, Widget child) {
            ForecastWeather weather = weatherProvider.forecastWeather;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                CustomBorder(
                  child: WeatherDetail(
                      weather.consolidatedWeather[0],
                      City(
                          woeid: weather.woeid,
                          title: weather.title,
                          locationType:
                              locationTypeValues.map[weather.locationType],
                          lattLong: weather.lattLong)),
                ),
                CustomBorder(
                  child: WindWidget(
                      weather.consolidatedWeather[0].windSpeed,
                      weather.consolidatedWeather[0].humidity,
                      weather.consolidatedWeather[0].visibility),
                ),
                WeatherWidgetList(forecastWeather: weather),
              ],
            );
          }),
        ));
  }
}
