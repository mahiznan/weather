import 'package:flutter/material.dart';
import 'package:weather/core/model/forecast_weather.dart';
import 'package:weather/ui/widgets/min_max_temp_widget.dart';

class WeatherDetail extends StatelessWidget {
  final ConsolidatedWeather _weather;
  final String _title;

  const WeatherDetail(this._weather, this._title, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Divider(
              color: Colors.transparent,
            ),
            Text(
              _title.toUpperCase(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            Divider(
              color: Colors.transparent,
            ),
            Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                Text(
                  '${_weather.theTemp}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 128,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  '\u00B0',
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ],
            ),
            Divider(
              color: Colors.transparent,
            ),
            MinMaxTempWidget(_weather.minTemp, _weather.maxTemp),
          ],
        ),
      ),
    );
  }
}
