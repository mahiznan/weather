import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/forecast_weather.dart';
import 'package:weather/ui/helper.dart';
import 'package:weather/ui/menu/app_menu_drawer.dart';
import 'package:weather/ui/menu/app_search_bar.dart';
import 'package:weather/ui/providers/weather_provider.dart';
import 'package:weather/ui/widgets/weather_detail_widget.dart';
import 'package:weather/ui/widgets/wind_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        endDrawer: AppMenuDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.black38,
          iconTheme: new IconThemeData(color: Colors.grey[800]),
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
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // stops: [0.2, 0.8],
            ),
          ),
          child: Consumer<WeatherProvider>(builder: (BuildContext context,
              WeatherProvider weatherProvider, Widget child) {
            ForecastWeather weather = weatherProvider.forecastWeather;
            return weatherProvider.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomBorder(
                        child: WeatherDetail(
                            weather.consolidatedWeather[0], weather.title),
                      ),
                      CustomBorder(
                        child: Divider(),
                      ),
                      CustomBorder(
                        child: WindWidget(
                            weather.consolidatedWeather[0].windSpeed,
                            weather.consolidatedWeather[0].humidity,
                            weather.consolidatedWeather[0].visibility),
                      )
                    ],
                  );
          }),
        ));
  }
}

/*Container(
                        color: Colors.grey[800],
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
                                  Icons.refresh,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                            ),
                            Divider(),
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: 8, right: 8, top: 8),
                              child: Consumer<WeatherProvider>(builder:
                                  (BuildContext context,
                                      WeatherProvider weatherProvider,
                                      Widget child) {
                                return Text(
                                  DateFormat("dd MMM hh:mm:ss a")
                                      .format(DateTime.now()),
                                  style: TextStyle(color: Colors.white),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      ForecastWidgetList(
                        forecastWeather: weatherProvider.forecastWeather,
                      )*/
