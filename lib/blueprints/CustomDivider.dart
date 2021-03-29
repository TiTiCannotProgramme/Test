import 'package:flutter/material.dart';

import '../providers/constants.dart';


class CustomDivider extends StatelessWidget {
  final double size;
  final Color color;

  CustomDivider({this.size = kCustomDividerHeight, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      child: Center(
        child: Container(
          margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
          height: size,
          color: color,
        ),
      ),
    );
  }
}
