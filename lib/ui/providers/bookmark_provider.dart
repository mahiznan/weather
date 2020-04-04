import 'package:flutter/material.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/core/services/db_helper.dart';

class BookmarkProvider with ChangeNotifier {
  bool _isBookMarked = false;
  final DatabaseHelper dbHelper;
  bool _loading = true;

  BookmarkProvider({@required this.dbHelper});

  void updateBookMark(City city) async {
    busy(true);
    if (await dbHelper.insertBookMark(city) > 0) {
      _isBookMarked = true;
    } else {
      await dbHelper.delete(city.woeid);
      _isBookMarked = false;
    }
    busy(false);
  }

  void checkBookmarkStatus(int woeid) async {
    busy(true);
    if (await dbHelper.notExist(woeid)) {
      _isBookMarked = false;
    } else {
      _isBookMarked = true;
    }
    busy(false);
  }

  void busy(bool v) {
    _loading = v;
    notifyListeners();
  }

  get loading => _loading;
  get isBookmarked => _isBookMarked;
}
