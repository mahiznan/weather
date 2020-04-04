import 'package:flutter/material.dart';
import 'package:weather_icons/weather_icons.dart';

class WindWidget extends StatelessWidget {
  final double _windSpeed;
  final int _humitidy;
  final double _visibility;

  const WindWidget(this._windSpeed, this._humitidy, this._visibility, {Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        getMiniWeatherWidget(
            WeatherIcons.wind_direction, 'WIND', '$_windSpeed', 'km/h'),
        SizedBox(
          width: 20,
        ),
        getMiniWeatherWidget(
            WeatherIcons.humidity, 'HUMITITY', '$_humitidy', '%'),
        SizedBox(
          width: 20,
        ),
        getMiniWeatherWidget(
            WeatherIcons.fog, 'VISIBILITY', '$_visibility', 'km'),
      ],
    );
  }

  Widget getMiniWeatherWidget(
      IconData icon, String title, String value, String unit) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BoxedIcon(
          icon,
          color: Colors.blue[300],
          size: 24,
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.blue[300]),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          '$value $unit',
          style: TextStyle(
              fontSize: 20,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
