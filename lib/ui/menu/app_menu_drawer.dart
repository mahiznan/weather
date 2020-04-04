import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/model/city.dart';
import 'package:weather/core/services/db_helper.dart';
import 'package:weather/ui/menu/app_routes.dart';

class AppMenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 30),
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(top: 70),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(70)),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(13, 53, 147, 1),
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 16),
              icon: Icon(
                Icons.home,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, AppRoutes.Home);
              },
            ),
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 16),
              icon: Icon(
                Icons.bookmark,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () async {
                List<City> cities =
                    await Provider.of<DatabaseHelper>(context, listen: false)
                        .queryAllRows();
                Navigator.popAndPushNamed(context, AppRoutes.Bookmark,
                    arguments: cities);
              },
            ),
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 16),
              icon: Icon(
                Icons.help,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, AppRoutes.Sliver);
              },
            ),
          ],
        ),
      ),
    );
  }
}
