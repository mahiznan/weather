import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/forecast_weather.dart';
import 'package:weather/ui/menu/app_menu_drawer.dart';
import 'package:weather/ui/menu/app_search_bar.dart';
import 'package:weather/ui/providers/weather_provider.dart';
import 'package:weather/ui/widgets/forecast_widget.dart';
import 'package:weather/ui/widgets/weather_detail_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppMenuDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.orange[800],
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
              Colors.orange[900],
              Colors.orange[500],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Consumer<WeatherProvider>(
            builder: (BuildContext context, WeatherProvider weatherProvider,
                Widget child) {
              ForecastWeather weather = weatherProvider.forecastWeather;
              return weatherProvider.loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .5,
                          child: WeatherDetail(
                              weather.consolidatedWeather[0], weather.title),
                        ),
                        Container(
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
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.white, Colors.orange[400]],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: ForecastWidgetList(
                              forecastWeather: weatherProvider.forecastWeather,
                            ),
                          ),
                        )
                      ],
                    );
            },
          ),
        ),
      ),
    );
  }
}
