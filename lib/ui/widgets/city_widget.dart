import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/ui/providers/bookmark_provider.dart';
import 'package:weather/ui/providers/favorite_provider.dart';

class CityWidget extends StatelessWidget {
  final City _city;
  final Function _onTap;

  const CityWidget(this._city, this._onTap, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('${_city.woeid}'),
      child: Card(
        color: Colors.transparent,
        child: ListTile(
          leading: Icon(
            Icons.location_on,
            color: Colors.white.withOpacity(0.9),
            size: 32,
          ),
          title: Text(
            _city.title,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          subtitle: Text(
            _city.lattLong,
            style: TextStyle(color: Colors.black.withOpacity(0.9)),
          ),
          trailing: _city.isFavorite == 1
              ? Icon(Icons.favorite, color: Colors.white.withOpacity(0.9))
              : null,
          onTap: _onTap,
        ),
      ),
      onDismissed: (direction) {
        Provider.of<BookmarkProvider>(context, listen: false)
            .removeBookMark(_city);
        Provider.of<BookmarkProvider>(context, listen: false)
            .checkBookmarkStatus(_city.woeid);
        Provider.of<FavoriteProvider>(context, listen: false)
            .checkFavoriteStatus(_city.woeid);
      },
    );
  }
}
