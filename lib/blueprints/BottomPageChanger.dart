import 'package:flutter/material.dart';

import '../providers/constants.dart';
import 'changePageButton.dart';
import '../providers/soundPageManager.dart';




class BottomPageChanger extends StatelessWidget {

  final Function lastFunction;
  final Function nextFunction;

  BottomPageChanger({this.lastFunction, this.nextFunction, Key key}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: kChangePageButtonFlexValue,
            child: ChangePageButton(
              nextOrLastPage: NextOrLastPage.lastPage,
              onPressed: lastFunction,
            ),
          ),
          Expanded(
            flex: 3,
            child: SizedBox(
              child: Center(
                child: Text(
                  SoundPageManager.showPageNumberAtBottom(),
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: kChangePageButtonFlexValue,
            child: ChangePageButton(
              nextOrLastPage: NextOrLastPage.nextPage,
              onPressed: nextFunction,
            ),
          ),
        ],
      ),
    );
  }
}
