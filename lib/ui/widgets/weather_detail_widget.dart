import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather/core/model/forecast_weather.dart';

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
          _weather.weatherStateName,
          style: TextStyle(color: Colors.white, fontSize: 36),
        ),
        Text(
          _title,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Divider(),
        SvgPicture.network(
          'https://www.metaweather.com/static/img/weather/${_weather.weatherStateAbbr}.svg',
          height: 90,
          color: Colors.white,
        ),
        Divider(),
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
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                '\u00B0',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    )));
  }
}
