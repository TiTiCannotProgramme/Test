import 'package:flutter/material.dart';
import 'package:after_layout/after_layout.dart';
import 'package:sound_button_beta/providers/soundPageManager.dart';

import '../blueprints/BottomPageChanger.dart';
import '../blueprints/buttonInfo.dart';
import 'soundPageManager.dart';
import 'constants.dart';
import '../blueprints/customDrawer.dart';
import '../blueprints/wrapedSoundButton.dart';
import '../blueprints/wrapHeader.dart';

class LayoutFinder {
  static double bottomButtonHeight;
  static bool bottomHeightDetermined = false;
}

class LayoutWidget extends StatefulWidget {
  static const routeName = 'test';
  @override
  _LayoutWidgetState createState() => _LayoutWidgetState();
}

class _LayoutWidgetState extends State<LayoutWidget>{
  bool bottomHeightDetermined = false;
  ButtonType currentButtonType = ButtonType.ds3;
  List<ButtonInfo> currentButtonList;
  List<WrapedSoundButton> buildButtonList = [];
  GlobalKey bottomKey = GlobalKey();
  GlobalKey wrapKey = GlobalKey();
  double widgetHeight = 10;
  int currentButtonNumber = 0;
  bool layoutFinished = false;

  @override
  void initState() {
    currentButtonList = SoundPageManager.getListByType(currentButtonType);
    Future.doWhile(() async {
      if (bottomHeightDetermined == true) {
        buildButtonList.add(WrapedSoundButton(
            currentButtonList[currentButtonNumber], 0, () {}, SoundPageManager.currentLanguage));
        currentButtonNumber++;
        setState(() {
          print('state has been set');
        });
        print('new button added, now button number is $currentButtonNumber');
        await Future.delayed(Duration(milliseconds: 300));
      }
      else{
        await Future.delayed(Duration(milliseconds: 30));
      }
      //_getWrapChangerHeight();
      return buildButtonList.length != 10;
    });
    super.initState();
  }



  void afterMoreLayout(BuildContext context) {
    _getWrapChangerHeight();
  }

  void _afterLayout() {
    _getBottomChangerHeight();
    setState(() {
        bottomHeightDetermined = true;
    });
    print('bottomHeight is determined');
  }

  void _getBottomChangerHeight() {
    print(LayoutFinder.bottomButtonHeight);
    final RenderBox renderBoxBottom =
        bottomKey.currentContext.findRenderObject();
    final bottomHeight = renderBoxBottom.size.height;
    print('first thing $bottomHeight');
    LayoutFinder.bottomButtonHeight = bottomHeight;
    print('layout thing ${LayoutFinder.bottomButtonHeight}');
  }

  void _getWrapChangerHeight() {
    final RenderBox renderBoxWrap = wrapKey.currentContext.findRenderObject();
    final wrapHeight = renderBoxWrap.size.height;
    widgetHeight = wrapHeight;
    print('wrap height is $wrapHeight');
    print(buildButtonList.length);
  }

  Column buildBottomButtonOnly() {
    return Column(
      children: <Widget>[
        BottomPageChanger(
          key: bottomKey,
        ),
      ],
    );
  }

  Widget buildColumn(List<Widget> list) {
    return Wrap(
      key: wrapKey,
      children: <Widget>[
        ...list,
        BottomPageChanger(
            //key: bottomKey,
            ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (bottomHeightDetermined == true) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => afterMoreLayout(context));
      print('called after more layout');
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout());
    }
    return Scaffold(
      appBar: AppBar(),
      drawer: Container(
        width: kDrawerWidth,
        child: CustomDrawer(),
      ),
      body: Column(
        children: [
          Offstage(
            offstage: false,
            child: bottomHeightDetermined
                ? buildColumn(buildButtonList)
                : buildBottomButtonOnly(),
          ),
          MaterialButton(
            child: Text("increase"),
            onPressed: () {
              setState(() {
                currentButtonNumber++;
                buildButtonList.add(WrapedSoundButton(
                    currentButtonList[currentButtonNumber], 0, () {}, SoundPageManager.currentLanguage));
              });
            },
          ),
        ],
      ),
    );
  }
}
