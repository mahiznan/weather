import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/core/services/db_helper.dart';
import 'package:weather/ui/menu/app_routes.dart';
import 'package:weather/ui/providers/weather_provider.dart';
import 'package:weather/ui/widgets/city_widget.dart';

class SearchCityScreen extends StatelessWidget {
  final List<City> _cities;

  const SearchCityScreen(this._cities, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromRGBO(65, 151, 199, 1),
          Color.fromRGBO(13, 53, 147, 1),
        ], begin: Alignment.topLeft, end: Alignment.bottomRight),
      ),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return CityWidget(_cities[index], () {
            Provider.of<WeatherProvider>(context, listen: false)
                .fetchForecastWeather(_cities[index].woeid);
            Provider.of<DatabaseHelper>(context, listen: false)
                .insertBookMark(_cities[index]);
            Navigator.pushReplacementNamed(context, AppRoutes.Home);
          });
        },
        itemCount: _cities != null ? _cities.length : 0,
      ),
    );
  }
}
