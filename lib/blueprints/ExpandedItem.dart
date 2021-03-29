import 'package:flutter/material.dart';

import '../providers/constants.dart';


class ExpandedItem extends StatelessWidget {
  final String text;
  final bool selected;
  final Function onPressed;

  ExpandedItem({this.text, this.selected, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: kExpandablePanelHeaderHeight * 0.75,
            //color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                kDrawerWidth * 0.1,
                kExpandablePanelHeaderHeight * 0.75 * 0.3,
                3.0,
                kExpandablePanelHeaderHeight * 0.75 * 0.3,
              ),
              child: FittedBox(
                child: Text(
                  text,
                  // style: TextStyle(
                  //   fontSize: kExpandablePanelHeaderHeight * 0.25,
                  // ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: kDrawerWidth * 0.1),
            child: selected ? Icon(
              Icons.check,
              color: Colors.green,
            )
            :
            SizedBox(),
          ),
        ],
      ),
    );
  }
}
