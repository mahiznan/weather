import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/core/services/db_helper.dart';
import 'package:weather/ui/menu/app_routes.dart';
import 'package:weather/ui/providers/bookmark_provider.dart';
import 'package:weather/ui/providers/favorite_provider.dart';
import 'package:weather/ui/providers/weather_provider.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();
    getPreferredCity();
  }

  void getPreferredCity() async {
    City city = await Provider.of<DatabaseHelper>(context, listen: false)
        .getFavoriteCity();
    if (city == null) {
      city = City(
          woeid: 2295424,
          locationType: LocationType.CITY,
          title: 'Chennai',
          lattLong: '13.05939,80.245667',
          isFavorite: 0);
    }
    Provider.of<WeatherProvider>(context, listen: false)
        .fetchForecastWeather(city.woeid);
    Provider.of<BookmarkProvider>(context, listen: false)
        .checkBookmarkStatus(city.woeid);
    Provider.of<FavoriteProvider>(context, listen: false)
        .checkFavoriteStatus(city.woeid);
    Navigator.pushReplacementNamed(context, AppRoutes.Home);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
            child: Text(
          'Getting default institution...',
          style: TextStyle(color: Colors.white.withOpacity(.7), fontSize: 16),
        )),
      ),
    );
  }
}
