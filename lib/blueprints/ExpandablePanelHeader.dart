import 'package:flutter/material.dart';

import '../providers/constants.dart';

class ExpandablePanelHeader extends StatelessWidget {
  final String title;

  ExpandablePanelHeader({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kExpandablePanelHeaderHeight,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FittedBox(
          child: Text(
            title,
            //style: Theme.of(context).textTheme.body2,
          ),
        ),
      ),
    );
  }
}
