import 'package:flutter/material.dart';

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
              Colors.orange[900],
              Colors.orange[500],
              Colors.orange[300],
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
                Icons.dashboard,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 16),
              icon: Icon(
                Icons.bookmark,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 16),
              icon: Icon(
                Icons.build,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            IconButton(
              padding: const EdgeInsets.symmetric(vertical: 16),
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
                size: 32,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
