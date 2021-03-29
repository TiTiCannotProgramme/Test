import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../providers/soundPageManager.dart';
import '../providers/constants.dart';
import 'buttonInfo.dart';

enum NextOrLastPage {nextPage, lastPage }

class ChangePageButton extends StatelessWidget {
  final NextOrLastPage nextOrLastPage;
  final Function onPressed;

  ChangePageButton({this.nextOrLastPage, this.onPressed});

  bool visibility(NextOrLastPage nextOrLastPage) {
    bool showPage;
    if (nextOrLastPage == NextOrLastPage.nextPage) {
      (SoundPageManager.currentPageNumber == SoundPageManager.maxPageNumber)
          ? showPage = false
          : showPage = true;
    } else {
      (SoundPageManager.currentPageNumber == 1) ? showPage = false : showPage = true;
    }
    return showPage;
  }

  String buttonText(NextOrLastPage nextOrLastPage) {
    if (nextOrLastPage == NextOrLastPage.nextPage) {
      if(SoundPageManager.currentLanguage == Language.en){
        return 'Next Page';
      }
      else if (SoundPageManager.currentLanguage == Language.cn){
        return '下一頁';
      }
    } else {
      if(SoundPageManager.currentLanguage == Language.en){
        return 'Last Page';
      }
      else if (SoundPageManager.currentLanguage == Language.cn){
        return '上一頁';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility(nextOrLastPage),
      child: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: kChangePageButtonColor,
            border: Border.all(
              width: 2,
              color: Colors.white70,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: MaterialButton(
            enableFeedback: true,
            onPressed: onPressed,
            child: AutoSizeText(
              buttonText(nextOrLastPage),
              textAlign: TextAlign.center,
              maxLines: 1,
              style: TextStyle(
                fontFamily: 'Quicksand',
                color: Theme.of(context).textTheme.bodyText1.color,
              ),
            ),
          ),
        ),
      ),
      replacement: Theme(
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
