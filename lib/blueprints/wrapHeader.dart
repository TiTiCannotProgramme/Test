import 'package:flutter/material.dart';

import 'CustomDivider.dart';
import 'buttonInfo.dart';
import '../providers/constants.dart';


class WarpHeader extends StatelessWidget {
  final ButtonType buttonType;

  WarpHeader({@required this.buttonType});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          //SizedBox(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: CustomDivider(
                size: 2,
                color: kWrapHeaderColor,
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                getButtonTypeText(buttonType),
                style: TextStyle(
                  color: kWrapHeaderColor,
                  fontSize: wrapButtonHeight(context) * 0.5,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: CustomDivider(
                size: 2,
                color: kWrapHeaderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
