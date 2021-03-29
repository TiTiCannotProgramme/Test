import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';

import '../blueprints/buttonInfo.dart';
import 'LayoutFinder.dart';
import 'soundPageManager.dart';

List<ButtonInfo> soundButtonInfoList = [
  ButtonInfo(
    {
      Language.en: "I've seen your kind, time and time again... but it's James",
      Language.cn: 'James配音的Vilhelm對白'
    },
    'Vilhelm_James.wav',
    17,
    ButtonType.ds3,
  ),
  ButtonInfo({Language.en: 'Vilhelm dialogue', Language.cn: 'Vilhelm對白'},
      'Vilhelm.mp3', 22, ButtonType.ds3),
  ButtonInfo({
    Language.en: '1Pickle Pee and Pump-a-Rum dialogue',
    Language.cn: '1Pickle Pee對白',
  }, 'Pickle_Pee.mp3', 67, ButtonType.ds3),
  ButtonInfo({
    Language.en: '2Pickle Pee and Pump-a-Rum dialogue',
    Language.cn: '2Pickle Pee對白',
  }, 'Pickle_Pee.mp3', 67, ButtonType.ds3),
  ButtonInfo({
    Language.en: '3Pickle Pee and Pump-a-Rum dialogue',
    Language.cn: '3Pickle Pee對白',
  }, 'Pickle_Pee.mp3', 67, ButtonType.ds3),
  ButtonInfo({
    Language.en: '4Pickle Pee and Pump-a-Rum dialogue',
    Language.cn: '4Pickle Pee對白',
  }, 'Pickle_Pee.mp3', 67, ButtonType.ds3),
  ButtonInfo({
    Language.en: '5Pickle Pee and Pump-a-Rum dialogue',
    Language.cn: '5Pickle Pee對白',
  }, 'Pickle_Pee.mp3', 67, ButtonType.ds3),
  ButtonInfo({
    Language.en: '6Pickle Pee and Pump-a-Rum dialogue',
    Language.cn: '6Pickle Pee對白',
  }, 'Pickle_Pee.mp3', 67, ButtonType.ds3),
  ButtonInfo({
    Language.en: '7Pickle Pee and Pump-a-Rum dialogue',
    Language.cn: '7Pickle Pee對白',
  }, 'Pickle_Pee.mp3', 67, ButtonType.ds3),
  ButtonInfo({
    Language.en: '8Pickle Pee and Pump-a-Rum dialogue',
    Language.cn: '8Pickle Pee對白',
  }, 'Pickle_Pee.mp3', 67, ButtonType.ds3),
  ButtonInfo({
    Language.en: '9Pickle Pee and Pump-a-Rum dialogue',
    Language.cn: '9Pickle Pee對白',
  }, 'Pickle_Pee.mp3', 67, ButtonType.ds3),
  ButtonInfo({
    Language.en: '10Pickle Pee and Pump-a-Rum dialogue',
    Language.cn: '10Pickle Pee對白',
  }, 'Pickle_Pee.mp3', 67, ButtonType.ds3),
  ButtonInfo({
    Language.en: "Ashe seeks embers",
    Language.cn: '灰塵追逐篝火',
  }, 'Pickle_Pee.mp3', 67, ButtonType.ds3),
  ButtonInfo({
    Language.en: 'Shira first encounter dialogue',
    Language.cn: 'Shira第一次對白',
  }, 'Shira.mp3', 37, ButtonType.ds3),
  ButtonInfo({
    Language.en: 'Caged person dialogue',
    Language.cn: '籠中之人對白',
  }, 'Caged_Fellow.mp3', 15, ButtonType.ds3),
  ButtonInfo({
    Language.en: "Ashe seeks embers",
    Language.cn: '灰塵追逐篝火',
  }, 'Miscellaneous.mp3', 17, ButtonType.ds3),
  ButtonInfo({
    Language.en: "7",
    Language.cn: '7',
  }, 'note7.wav', 0, ButtonType.ds3),
  ButtonInfo({
    Language.en: "8",
    Language.cn: '8',
  }, 'note1.wav', 0, ButtonType.test),
  ButtonInfo({
    Language.en: "9",
    Language.cn: '9',
  }, 'note2.wav', 0, ButtonType.test),
  ButtonInfo({
    Language.en: "10",
    Language.cn: '10',
  }, 'note3.wav', 0, ButtonType.test),
  ButtonInfo({
    Language.en: "11",
    Language.cn: '11',
  }, 'note4.wav', 0, ButtonType.test),
  ButtonInfo({
    Language.en: "12",
    Language.cn: '12',
  }, 'note5.wav', 0, ButtonType.test),
  ButtonInfo({
    Language.en: "13",
    Language.cn: '13',
  }, 'note6.wav', 0, ButtonType.test),
  ButtonInfo({
    Language.en: "14",
    Language.cn: '14',
  }, 'note7.wav', 0, ButtonType.test),
  ButtonInfo({
    Language.en: "15",
    Language.cn: '15',
  }, 'note3.wav', 0, ButtonType.test),
];

const kMaxButtonsPerPage = 6;

const kChangePageButtonFlexValue = 3;

const kChangePageButtonColor = Color(0x00000000);

const kSoundButtonFlexValue = 5;

const kDrawerWidth = 250.0;

const kCustomDividerHeight = 0.2;

const kExpandablePanelHeaderHeight = 55.0;

const kExpandableThemeData = ExpandableThemeData(
  headerAlignment: ExpandablePanelHeaderAlignment.center,
  tapBodyToExpand: true,
  tapBodyToCollapse: false,
);

//these two are not dynamically calculated, one is from the padding another one is from ButtonTheme in the Theme
const double kBottomButtonHeight = 36.0;
const double kBottomButtonTotalPadding = 30;

double wrapButtonHeight(BuildContext context) {
  return (MediaQuery.of(context).size.height -
          kToolbarHeight -
          MediaQuery.of(context).padding.top -
          LayoutFinder.bottomButtonHeight) /
      11.0;
}

const kWrapHeaderColor = Colors.blueGrey;

// ignore: missing_return
String getButtonTypeText(ButtonType buttonType) {
  if (buttonType == ButtonType.ds3) {
    if (SoundPageManager.currentLanguage == Language.en) {
      return 'Dark Souls 3';
    } else if (SoundPageManager.currentLanguage == Language.cn) {
      return '黑暗之魂3';
    }
  } else if (buttonType == ButtonType.test) {
    if (SoundPageManager.currentLanguage == Language.en) {
      return 'test';
    } else if (SoundPageManager.currentLanguage == Language.cn) {
      return '實驗';
    }
  } else {
    if (SoundPageManager.currentLanguage == Language.en) {
      return 'All';
    } else if (SoundPageManager.currentLanguage == Language.cn) {
      return '全部';
    }
  }
}

String getViewTypeText(ViewType viewType) {
  if (viewType == ViewType.listView) {
    if (SoundPageManager.currentLanguage == Language.en) {
      return 'List View';
    } else if (SoundPageManager.currentLanguage == Language.cn) {
      return '列表';
    }
  } else if (viewType == ViewType.pageView) {
    if (SoundPageManager.currentLanguage == Language.en) {
      return 'Page View';
    } else if (SoundPageManager.currentLanguage == Language.cn) {
      return '頁面';
    }
  }
}

String getButtonLayoutTypeText(ButtonLayoutType buttonLayoutType) {
  if (buttonLayoutType == ButtonLayoutType.stretch) {
    if (SoundPageManager.currentLanguage == Language.en) {
      return 'Stretch';
    } else if (SoundPageManager.currentLanguage == Language.cn) {
      return '伸展';
    }
  } else if (buttonLayoutType == ButtonLayoutType.wrap) {
    if (SoundPageManager.currentLanguage == Language.en) {
      return 'Wrap';
    } else if (SoundPageManager.currentLanguage == Language.cn) {
      return '包裹';
    }
  }
}

String getLanguageText(Language language){
  if (language == Language.en){
    if (SoundPageManager.currentLanguage == Language.en) {
      return 'English';
    } else if (SoundPageManager.currentLanguage == Language.cn) {
      return '英語';
    }
  }
  if (language == Language.cn){
    if (SoundPageManager.currentLanguage == Language.en) {
      return 'Chinese';
    } else if (SoundPageManager.currentLanguage == Language.cn) {
      return '中文';
    }
  }
}

String getTheAppText(){
  if (SoundPageManager.currentLanguage == Language.en) {
    return 'The App';
  } else if (SoundPageManager.currentLanguage == Language.cn) {
    return '這款軟件';
  }
}
