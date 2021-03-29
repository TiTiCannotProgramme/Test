import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'buttonInfo.dart';
import '../providers/constants.dart';

class WrapedSoundButton extends StatelessWidget {
  final ButtonInfo buttonInfo;
  final double gradientValue;
  final Function function;
  final Language language;

  WrapedSoundButton(this.buttonInfo, this.gradientValue, this.function, this.language);

  @override
  Widget build(BuildContext context) {

    double buttonWidth = (MediaQuery.of(context).size.width - 30)/2;
    double buttonHeight = wrapButtonHeight(context);
    double textSize = wrapButtonHeight(context) * 0.35;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: GestureDetector(
        onTap: function,
        child: IntrinsicWidth(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: buttonHeight,
              maxHeight: buttonHeight,
              maxWidth: buttonWidth,
              minWidth: buttonWidth /4,
            ),
            child: Container(
              //height: buttonHeight,
              //width: buttonWidth,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3,
                  color: Theme.of(context).buttonColor,
                ),
                gradient: LinearGradient(
                  colors: [Theme.of(context).buttonColor.withOpacity(0.7), Color(0x00000000)],
                  stops: [gradientValue, gradientValue],
                ),
                borderRadius: BorderRadius.circular(15),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black.withOpacity(0.8),
                //     blurRadius: 7,
                //     offset: const Offset(0, 6),
                //   ),
                // ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    buttonInfo.getButtonText(language),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: textSize,
                      fontFamily: 'Itim',
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// MaterialButton(
// enableFeedback: false,
// onPressed: function,
// child: AutoSizeText(
// buttonInfo.getButtonText(),
// style: TextStyle(
// fontSize: 30,
// fontFamily: 'Itim',
// ),
// ),
// )
