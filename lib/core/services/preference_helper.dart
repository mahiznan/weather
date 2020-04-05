import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/model/city.dart';

class SharedPreferencesHelper {
  static Future<City> getPreferredCity() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.containsKey("preferredCity")) {
      return City.fromJson(json.decode(_prefs.getString("preferredCity")));
    }
    return null;
  }

  static Future<bool> setPreferredCity(City city) async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.setString("preferredCity", json.encode(city.toJson()));
  }

  static Future<bool> removePreferredCity() async {
    final SharedPreferences _prefs = await SharedPreferences.getInstance();
    print('Removing token ${_prefs.getString("preferredCity")}');
    return _prefs.remove("preferredCity");
  }
}
