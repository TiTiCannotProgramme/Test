import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:sound_button_beta/blueprints/CustomDivider.dart';

import '../providers/constants.dart';
import '../blueprints/wrapedSoundButton.dart';
import '../providers/soundPageManager.dart';
import '../blueprints/buttonInfo.dart';
import '../blueprints/changePageButton.dart';
import '../blueprints/customDrawer.dart';
import '../blueprints/wrapHeader.dart';
import '../blueprints/BottomPageChanger.dart';

class WrapedSoundPage extends StatefulWidget {
  static const routeName = 'WrapedSoundPageRoute';
  @override
  _WrapedSoundPageState createState() => _WrapedSoundPageState();
}

class _WrapedSoundPageState extends State<WrapedSoundPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    SoundPageManager.getMaxPageNumber(ButtonLayoutType.wrap, ButtonType.all);
    SoundPageManager.currentPageNumber = 1;
    _animationController = AnimationController(vsync: this);
    _animationController.addListener(() {
      setState(() {});
    });
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _animationController.reset();
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    SoundPageManager.assetsAudioPlayer.stop();
    _animationController.dispose();
    super.dispose();
  }

  void stopCurrentSoundAndAnimation() {
    _animationController.stop();
    _animationController.reset();
    SoundPageManager.assetsAudioPlayer.stop();
  }

  Widget singleSoundButton(ButtonInfo buttonInfo) {
    return WrapedSoundButton(
      buttonInfo,
      buttonInfo.getButtonFileName() == SoundPageManager.currentPlayingButtonID
          ? _animationController.value
          : 0,
      () {
        SoundPageManager.currentPlayingButtonID =
            buttonInfo.getButtonFileName();
        if (_animationController.isAnimating) {
          _animationController.stop();
          _animationController.reset();
        }
        SoundPageManager.assetsAudioPlayer.open(
          Audio("assets/audios/${buttonInfo.getButtonFileName()}"),
          showNotification: false,
        );
        _animationController.duration =
            Duration(milliseconds: buttonInfo.getAudioLength() * 1000 + 300);
        _animationController.forward();
      },
      SoundPageManager.currentLanguage,
    );
  }

  List<Widget> getAllButtonsByType(ButtonType type) {
    List<Widget> myList = [];
    for (ButtonInfo value in SoundPageManager.getListByType(type)) {
      myList.add(singleSoundButton(value));
    }
    return myList;
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<SoundPageManager>(context);
    return Scaffold(
      drawer: Container(
        width: kDrawerWidth,
        child: CustomDrawer(),
      ),
      appBar: AppBar(
        title: Text('SoundBoard Beta'),
        actions: [
          FittedBox(
            alignment: Alignment.topCenter,
            child: IconButton(
              splashRadius: 0.1,
              padding: const EdgeInsets.all(0.0),
              icon: Icon(
                Icons.stop_circle_outlined,
                color: Theme.of(context).errorColor.withOpacity(0.7),
                size: kToolbarHeight / 1.5,
              ),
              onPressed: () {
                stopCurrentSoundAndAnimation();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: buildInterface(manager),
      ),
    );
  }

  Widget buildInterface(SoundPageManager manager){
    if(SoundPageManager.currentButtonType == ButtonType.all){
      if(manager.viewType == ViewType.listView){
        return buildListView();
      }
      else{
        return buildPageView();
      }
    }
    else{
      return viewBySingleType(SoundPageManager.currentButtonType);
    }
  }

  Widget viewBySingleType(ButtonType buttonType){
    return SingleChildScrollView(
      child: Column(
        children: [
          WarpHeader(
            buttonType: buttonType,
          ),
          Wrap(
            children: getAllButtonsByType(buttonType),
          ),
        ],
      ),
    );
  }

  Widget buildListView() {
    List<Widget> myList = [];
    for (ButtonType value in ButtonType.values) {
      if(value != ButtonType.all){
        myList.add(
          WarpHeader(
            buttonType: value,
          ),
        );
        myList.add(
          Wrap(
            children: getAllButtonsByType(value),
          ),
        );
        myList.add(
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
          ),
        );
      }
    }
    return SingleChildScrollView(
      child: Column(
        children: myList,
      ),
    );
  }

  Column buildPageView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        WarpHeader(
          buttonType: ButtonType.values[SoundPageManager.currentPageNumber],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              children: getAllButtonsByType(
                  ButtonType.values[SoundPageManager.currentPageNumber]),
            ),
          ),
        ),
        BottomPageChanger(
          lastFunction: () {
            setState(() {
              SoundPageManager.changePage(NextOrLastPage.lastPage);
              stopCurrentSoundAndAnimation();
            });
          },
          nextFunction: () {
            setState(() {
              SoundPageManager.changePage(NextOrLastPage.nextPage);
              stopCurrentSoundAndAnimation();
            });
          },
        ),
      ],
    );
  }
}
