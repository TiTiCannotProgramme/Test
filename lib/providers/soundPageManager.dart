import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import '../blueprints/buttonInfo.dart';
import '../blueprints/changePageButton.dart';

enum ViewType { pageView, listView }
enum ButtonLayoutType { stretch, wrap }

class SoundPageManager with ChangeNotifier {
  static AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();
  static String currentPlayingButtonID;
  static int currentPageNumber;
  static int maxPageNumber;
  ViewType viewType = ViewType.pageView;
  ButtonLayoutType buttonLayoutType = ButtonLayoutType.stretch;
  static ButtonType currentButtonType = ButtonType.all;
  static Language currentLanguage = Language.en;

  static void getMaxPageNumber(ButtonLayoutType buttonLayoutType, ButtonType buttonType){
    if (buttonLayoutType == ButtonLayoutType.stretch) {
      maxPageNumber = (sortButtonInfoMap()[buttonType].length / kMaxButtonsPerPage).ceil();
    }
    else{
      maxPageNumber = ButtonType.values.length - 1;
    }
  }

  static List<ButtonInfo> getListByType(ButtonType type) {
    List<ButtonInfo> myList = [];
    for (var value in soundButtonInfoList) {
      if (value.getButtonType() == type) {
        myList.add(value);
      }
    }
    return myList;
  }

  static Map<ButtonType, List<ButtonInfo>> sortButtonInfoMap() {
    Map<ButtonType, List<ButtonInfo>> buttonInfoListByType = {
      ButtonType.all: soundButtonInfoList
    };
    for (var value in ButtonType.values) {
      if (value != ButtonType.all) {
        Map<ButtonType, List<ButtonInfo>> myMap = {value: getListByType(value)};
        buttonInfoListByType.addAll(myMap);
      }
    }
    //print(buttonInfoListByType);
    return buttonInfoListByType;
  }

  static String showPageNumberAtBottom() {
    return '$currentPageNumber / $maxPageNumber';
  }

  static void changePage(NextOrLastPage nextOrLastPage) {
    if (nextOrLastPage == NextOrLastPage.nextPage) {
      if (currentPageNumber != maxPageNumber) {
        currentPageNumber++;
      }
    } else {
      if (currentPageNumber != 1) {
        currentPageNumber--;
      }
    }
  }

  void changeViewType(ViewType newType){
    if (viewType == newType){
      return;
    }
    else{
      viewType = newType;
      notifyListeners();
    }
  }

  void changeButtonLayoutType(ButtonLayoutType newType){
    if (buttonLayoutType == newType){
      return;
    }
    else{
      buttonLayoutType = newType;
      print(newType);
      notifyListeners();
    }
  }

  void changeButtonType(ButtonType newButtonType){
    if(currentButtonType == newButtonType){
      return;
    }
    else{
      currentButtonType = newButtonType;
      SoundPageManager.getMaxPageNumber(buttonLayoutType, newButtonType);
      currentPageNumber = 1;
      notifyListeners();
    }
  }

  void changeLanguage(Language newLanguage){
    if (currentLanguage == newLanguage){
      return;
    }
    else{
      currentLanguage = newLanguage;
      notifyListeners();
    }
  }
}
