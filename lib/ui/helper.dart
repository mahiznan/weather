import 'package:flutter/material.dart';

class CustomBorder extends StatelessWidget {
  final Widget child;
  final Color color;

  CustomBorder({Key key, this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: color ?? Colors.transparent)),
      child: child,
    );
  }
}
