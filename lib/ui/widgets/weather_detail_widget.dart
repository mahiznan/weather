import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/core/model/forecast_weather.dart';
import 'package:weather/ui/providers/bookmark_provider.dart';
import 'package:weather/ui/providers/favorite_provider.dart';
import 'package:weather/ui/widgets/min_max_temp_widget.dart';

class WeatherDetail extends StatelessWidget {
  final ConsolidatedWeather _weather;
  final City _city;

  const WeatherDetail(this._weather, this._city, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Divider(
            color: Colors.transparent,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Consumer<BookmarkProvider>(builder: (BuildContext context,
                  BookmarkProvider bookmarkProvider, Widget child) {
                bool isBookmarked = bookmarkProvider.isBookmarked;
                print('Bookmark status $isBookmarked');
                return Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 40.0,
                          color: Colors.black54,
                          offset: Offset.zero),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: isBookmarked
                            ? Colors.white.withOpacity(0.9)
                            : Colors.white60,
                        size: 32.0),
                    onPressed: () {
                      if (isBookmarked) {
                        bookmarkProvider.removeBookMark(_city);
                        Provider.of<FavoriteProvider>(context, listen: false)
                            .removeFavorite(_city);
                      } else {
                        bookmarkProvider.insertBookMark(_city);
                      }
                    },
                  ),
                );
              }),
              Text(
                _city.title.toUpperCase(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              Consumer<FavoriteProvider>(builder: (BuildContext context,
                  FavoriteProvider favoriteProvider, Widget child) {
                bool isFavorite = favoriteProvider.isFavorite;
                print('Favorite status $isFavorite');
                return favoriteProvider.loading
                    ? CircularProgressIndicator()
                    : Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 40.0,
                                color: Colors.black54,
                                offset: Offset.zero),
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(
                              isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavorite
                                  ? Colors.white.withOpacity(0.9)
                                  : Colors.white60,
                              size: 32.0),
                          onPressed: () {
                            if (isFavorite) {
                              favoriteProvider.removeFavorite(_city);
                            } else {
                              favoriteProvider.setFavorite(_city);
                              Provider.of<BookmarkProvider>(context,
                                      listen: false)
                                  .checkBookmarkStatus(_city.woeid);
                            }
                          },
                        ),
                      );
              }),
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              Text(
                '${_weather.theTemp}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 128,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                '\u00B0',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ],
          ),
          Divider(
            color: Colors.transparent,
          ),
          MinMaxTempWidget(_weather.minTemp, _weather.maxTemp),
        ],
      ),
    );
  }
}
