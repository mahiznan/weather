import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/services/api_service.dart';
import 'package:weather/core/services/db_helper.dart';
import 'package:weather/ui/menu/app_routes.dart';
import 'package:weather/ui/providers/weather_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => WeatherProvider(),
        ),
        Provider(
          create: (_) => ApiService(),
        ),
        Provider(
          create: (_) => DatabaseHelper.instance,
        )
      ],
      child: WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: AppRoutes.Home,
      onGenerateRoute: Router.generateRoute,
    );
  }
}
