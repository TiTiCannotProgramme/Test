import 'package:flutter/material.dart';

class InvisibleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: MaterialButton(
          enableFeedback: false,
          onPressed: () {},
        ),
      ),
    );
  }
}
