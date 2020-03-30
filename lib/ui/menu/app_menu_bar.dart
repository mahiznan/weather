import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/core/services/api_service.dart';
import 'package:weather/ui/providers/weather_provider.dart';

class DataSearch extends SearchDelegate<String> {
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
    return FutureBuilder(
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.none &&
            asyncSnapshot.hasData == null) {
          return Container();
        }
        List<City> cities = asyncSnapshot.data;
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
                cities[index].title,
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Text(cities[index].lattLong),
              onTap: () {
                Provider.of<WeatherProvider>(context, listen: false)
                    .fetchForecastWeather(cities[index].woeid);
                close(context, null);
              },
            ),
            itemCount: cities != null ? cities.length : 0,
          ),
        );
      },
      future: Provider.of<ApiService>(context).fetchCitiesLike(query),
    );
  }
}
