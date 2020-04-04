import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/forecast_weather.dart';
import 'package:weather/ui/helper.dart';
import 'package:weather/ui/providers/weather_provider.dart';

class WeatherWidgetList extends StatelessWidget {
  final ForecastWeather forecastWeather;
  final int activeIndex;

  const WeatherWidgetList(
      {Key key, @required this.forecastWeather, this.activeIndex})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return WeatherWidget(
            forecast: forecastWeather.consolidatedWeather[index],
            activeIndex: activeIndex,
            currentIndex: index,
          );
        },
        itemCount: forecastWeather.consolidatedWeather.length < 5
            ? forecastWeather.consolidatedWeather.length
            : 5,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final ConsolidatedWeather forecast;
  final int currentIndex;
  final int activeIndex;
  const WeatherWidget(
      {Key key, @required this.forecast, this.currentIndex, this.activeIndex})
      : super(key: key);

  get isActive => currentIndex == activeIndex;

  @override
  Widget build(BuildContext context) {
    return CustomBorder(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              DateFormat("EEEE").format(forecast.applicableDate),
              style: TextStyle(
                  color: isActive
                      ? Colors.white.withOpacity(0.9)
                      : Colors.white.withOpacity(0.6),
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
            ),
            Divider(),
            InkWell(
              onTap: () {
                Provider.of<WeatherProvider>(context, listen: false)
                    .activeWeather = currentIndex;
              },
              child: SvgPicture.network(
                  'https://www.metaweather.com/static/img/weather/${forecast.weatherStateAbbr}.svg',
                  height: 38,
                  color: isActive
                      ? Colors.white.withOpacity(0.9)
                      : Colors.white.withOpacity(0.6)),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Text(
                  '${forecast.theTemp}',
                  style: TextStyle(
                      color: isActive
                          ? Colors.white.withOpacity(0.9)
                          : Colors.white.withOpacity(0.6),
                      fontSize: 14,
                      fontWeight:
                          isActive ? FontWeight.bold : FontWeight.normal),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    '\u00B0',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
