import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'buttonInfo.dart';
import '../providers/constants.dart';

class StretchedSoundButton extends StatelessWidget {
  final ButtonInfo buttonInfo;
  final double gradientValue;
  final Function function;
  final Language language;

  StretchedSoundButton(this.buttonInfo, this.gradientValue, this.function, this.language);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: GestureDetector(
        onTap: function,
        child: Container(
          //height: 70.0,
          height: (MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top) / (kMaxButtonsPerPage + 1) - 18,
          width: double.infinity,
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
              padding: EdgeInsets.all(6.0),
              child: AutoSizeText(
                buttonInfo.getButtonText(language),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Itim',
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
