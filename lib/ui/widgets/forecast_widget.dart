import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/core/model/forecast_weather.dart';

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
            forecast: forecastWeather.consolidatedWeather[index],
          ),
        );
      },
      itemCount: forecastWeather.consolidatedWeather.length,
      scrollDirection: Axis.horizontal,
    );
  }
}

class ForecastWidget extends StatelessWidget {
  final ConsolidatedWeather forecast;

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
                DateFormat("E").format(forecast.applicableDate).toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              Divider(),
              Text(
                DateFormat("dd MMM").format(forecast.applicableDate),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontStyle: FontStyle.italic),
              ),
              Divider(),
              SvgPicture.network(
                'https://www.metaweather.com/static/img/weather/${forecast.weatherStateAbbr}.svg',
                height: 50,
                color: Colors.white,
              ),
              Divider(),
              Text(
                '${forecast.weatherStateName}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontStyle: FontStyle.normal),
              ),
            ],
          ),
        ));
  }
}
