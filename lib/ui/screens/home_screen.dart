import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/forecast_weather.dart';
import 'package:weather/ui/menu/app_menu_drawer.dart';
import 'package:weather/ui/menu/app_search_bar.dart';
import 'package:weather/ui/providers/weather_provider.dart';
import 'package:weather/ui/widgets/weather_detail_widget.dart';
import 'package:weather/ui/widgets/weather_widget.dart';
import 'package:weather/ui/widgets/wind_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: AppMenuDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.grey[800],
          //iconTheme: new IconThemeData(color: Colors.grey[800]),
          leading: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                size: 30,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              },
            ),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(65, 151, 199, 1),
                Color.fromRGBO(13, 53, 147, 1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Consumer<WeatherProvider>(builder: (BuildContext context,
              WeatherProvider weatherProvider, Widget child) {
            ForecastWeather weather = weatherProvider.forecastWeather;
            int activeIndex = weatherProvider.activeIndex;
            ConsolidatedWeather activeWeather = weather != null
                ? weather.consolidatedWeather[activeIndex]
                : null;
            return weatherProvider.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(children: [
                    WeatherDetail(activeWeather, weather.title),
                    WindWidget(activeWeather.windSpeed, activeWeather.humidity,
                        activeWeather.visibility),
                    Divider(
                      color: Colors.transparent,
                    ),
                    Divider(),
                    WeatherWidgetList(
                        forecastWeather: weather, activeIndex: activeIndex),
                    Padding(
                        padding:
                            EdgeInsets.only(bottom: 16, right: 16, top: 16),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: InkWell(
                                  onTap: () {
                                    Provider.of<WeatherProvider>(context,
                                            listen: false)
                                        .fetchForecastWeather(weather.woeid);
                                  },
                                  child: Icon(
                                    Icons.timer,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat("dd MMM hh:mm:ss a")
                                    .format(DateTime.now()),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ],
                          ),
                        ))
                  ]);
          }),
        ));
  }
}
