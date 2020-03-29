import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/model/weather_forecast.dart';

class ForecastWidgetList extends StatelessWidget {
  final ForecastWeather forecastWeather;

  const ForecastWidgetList({Key key, @required this.forecastWeather})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(12),
          child: ForecastWidget(
            forecast: forecastWeather.list[index],
          ),
        );
      },
      itemCount: forecastWeather.list.length,
      scrollDirection: Axis.horizontal,
    );
  }
}

class ForecastWidget extends StatelessWidget {
  final Forecast forecast;

  const ForecastWidget({Key key, @required this.forecast}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.orange[400], Colors.orange[900]],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 8), blurRadius: 20)
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                DateFormat("E").format(forecast.dtTxt).toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                DateFormat("dd MMM").format(forecast.dtTxt),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
              Image.network(
                  "http://openweathermap.org/img/wn/${forecast.weather[0].icon}@2x.png"),
              Text(
                '${weatherCodeEnumValues.reverse[forecast.weather[0].code]}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ));
  }
}
