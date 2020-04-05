import 'package:flutter/material.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/core/services/db_helper.dart';

class FavoriteProvider with ChangeNotifier {
  bool _isFavorite = false;
  final DatabaseHelper dbHelper;
  bool _loading = true;

  FavoriteProvider({@required this.dbHelper});

  void setFavorite(City city) async {
    dbHelper.setFavoriteBookMark(city);
    _isFavorite = true;
    busy(false);
  }

  void removeFavorite(City city) async {
    dbHelper.removeFavoriteBookMark(city);
    _isFavorite = false;
    busy(false);
  }

  void checkFavoriteStatus(int woeid) async {
    if (await dbHelper.isFavorite(woeid)) {
      _isFavorite = true;
    } else {
      _isFavorite = false;
    }
    busy(false);
  }

  void busy(bool v) {
    _loading = v;
    notifyListeners();
  }

  get loading => _loading;
  get isFavorite => _isFavorite;
}
