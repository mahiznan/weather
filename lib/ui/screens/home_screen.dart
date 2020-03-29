import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/weather_forecast.dart';
import 'package:weather/ui/providers/weather_provider.dart';
import 'package:weather/ui/util.dart';
import 'package:weather/ui/widgets/forecast_widget.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[500],
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.menu,
              color: Colors.grey[800],
              size: 30,
            ),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.grey[800],
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .55,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.orange[500], Colors.orange[900]],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Center(child: Consumer<WeatherProvider>(builder:
                    (BuildContext context, WeatherProvider weatherProvider,
                        Widget child) {
                  CurrentWeather weather = weatherProvider.currentWeather;
                  return (weatherProvider.loading
                      ? CircularProgressIndicator()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Divider(
                              color: Colors.transparent,
                            ),
                            Text(
                              weatherCodeEnumValues.reverse[weather.weather[0].code],
                              style:
                                  TextStyle(color: Colors.white, fontSize: 36),
                            ),
                            Text(
                              weather.name,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            Divider(
                              color: Colors.transparent,
                            ),
                            Image.network(
                              "http://openweathermap.org/img/wn/${weather.weather[0].icon}@2x.png",
                            ),
                            Stack(
                              alignment: Alignment.topRight,
                              children: <Widget>[
                                Text(
                                  '${weather.detail.temp}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 128,
                                      fontWeight: FontWeight.w600),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Icon(
                                    WeatherIcons.degrees,
                                    color: Colors.white,
                                    size: 40,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ));
                })),
              ),
            ),
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
                      Provider.of<WeatherProvider>(context, listen: false)
                          .fetchCurrentWeather(2643743);
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
                  padding: EdgeInsets.only(bottom: 8, right: 8, top: 8),
                  child: Consumer<WeatherProvider>(builder:
                      (BuildContext context, WeatherProvider weatherProvider,
                          Widget child) {
                    return Text(
                      DateFormat("dd MMM hh:mm:ss a").format(DateTime.now()),
                      style: TextStyle(color: Colors.white),
                    );
                  }),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Consumer<WeatherProvider>(builder: (BuildContext context,
                  WeatherProvider weatherProvider, Widget child) {
                return weatherProvider.loading
                    ? CircularProgressIndicator()
                    : ForecastWidgetList(
                        forecastWeather: weatherProvider.forecastWeather,
                      );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  final List<WeatherCity> cities = [
    WeatherCity("Singapore", 1880252),
    WeatherCity("Chennai", 1264527),
    WeatherCity("Delhi", 1273293),
    WeatherCity("Pudukkottai", 1259297),
    WeatherCity("Tiruppur", 1254348),
    WeatherCity("Madurai", 1264521),
    WeatherCity("Tiruchirappalli", 1254388),
    WeatherCity("Tirupati", 1254360),
    WeatherCity("London", 2643743),
    WeatherCity("Arimalam", 1278409),
  ];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<WeatherCity> suggestedCities = [];
    if (query.isEmpty) {
      suggestedCities = cities;
    } else {
      cities.forEach((city) {
        if (city.name.contains(query)) {
          suggestedCities.add(city);
        }
      });
    }

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.orange[500], Colors.orange[900]],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: ListView.builder(
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.location_city),
          title: Text(
            suggestedCities[index].name,
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {
            Provider.of<WeatherProvider>(context, listen: false)
                .fetchCurrentWeather(suggestedCities[index].id);
            close(context, null);
          },
        ),
        itemCount: suggestedCities.length,
      ),
    );
  }
}
