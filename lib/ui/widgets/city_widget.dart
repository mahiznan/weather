import 'package:flutter/material.dart';
import 'package:weather/core/model/city.dart';

class CityWidget extends StatelessWidget {
  final City _city;
  final Function _onTap;

  const CityWidget(this._city, this._onTap, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
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
        trailing: Icon(
          Icons.bookmark_border,
          color: Colors.white.withOpacity(0.9),
        ),
        onTap: _onTap,
      ),
    );
  }
}
