import 'package:flutter/material.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/ui/screens/bookmark_screen.dart';
import 'package:weather/ui/screens/debug_screen.dart';
import 'package:weather/ui/screens/home_screen.dart';
import 'package:weather/ui/screens/sliver_screen.dart';

class AppRoutes {
  static const String Home = 'home';
  static const String Bookmark = 'bookmarks';
  static const String Sliver = 'slivers';
  static const String Debug = 'debug';
}

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.Home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoutes.Bookmark:
        var cities = settings.arguments as List<City>;
        return MaterialPageRoute(builder: (_) => BookMarkScreen(cities));
      case AppRoutes.Sliver:
        return MaterialPageRoute(builder: (_) => SliverScreen());
      case AppRoutes.Debug:
        return MaterialPageRoute(builder: (_) => DebugScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
