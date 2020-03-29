import 'package:flutter/material.dart';

class CustomBorder extends StatelessWidget {
  final Widget child;

  const CustomBorder({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //decoration: BoxDecoration(border: Border.all()),
      child: child,
    );
  }
}
