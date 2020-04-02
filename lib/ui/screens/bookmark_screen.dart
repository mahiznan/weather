import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/ui/menu/app_menu_drawer.dart';
import 'package:weather/ui/menu/app_routes.dart';
import 'package:weather/ui/providers/weather_provider.dart';
import 'package:weather/ui/widgets/city_widget.dart';

class BookMarkScreen extends StatelessWidget {
  final List<City> _cities;

  const BookMarkScreen(this._cities, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: AppMenuDrawer(),
      appBar: AppBar(
        title: Text('Bookmarks'),
        backgroundColor: Colors.orange[800],
        iconTheme: new IconThemeData(color: Colors.grey[800]),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.orange[500], Colors.orange[900]],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return CityWidget(_cities[index], () {
              Provider.of<WeatherProvider>(context, listen: false)
                  .fetchForecastWeather(_cities[index].woeid);
              Navigator.pushReplacementNamed(context, AppRoutes.Home);
            });
          },
          itemCount: _cities != null ? _cities.length : 0,
        ),
      ),
    );
  }
}
