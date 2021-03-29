import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:provider/provider.dart';

import '../providers/constants.dart';
import '../providers/soundPageManager.dart';
import 'CustomDivider.dart';
import 'ExpandedItem.dart';
import 'ExpandablePanelHeader.dart';
import 'buttonInfo.dart';
import '../pages/StretchedSoundPage.dart';
import '../pages/WrapedSoundPage.dart';
import '../pages/AppAboutPage.dart';

enum PanelType { viewOptions, buttonOptions, viewButtonType, language, about }

class CustomExpandablePanel extends StatelessWidget {
  final PanelType panelType;

  CustomExpandablePanel(this.panelType);

  String panelTypeName(PanelType panelType) {
    if (panelType == PanelType.viewOptions) {
      if (SoundPageManager.currentLanguage == Language.en) {
        return 'View Options';
      } else if (SoundPageManager.currentLanguage == Language.cn) {
        return '佈局';
      }
    } else if (panelType == PanelType.buttonOptions) {
      if (SoundPageManager.currentLanguage == Language.en) {
        return 'Button Options';
      } else if (SoundPageManager.currentLanguage == Language.cn) {
        return '按鈕外觀';
      }
    } else if (panelType == PanelType.viewButtonType) {
      if (SoundPageManager.currentLanguage == Language.en) {
        return 'View Button Type';
      } else if (SoundPageManager.currentLanguage == Language.cn) {
        return '按鈕類型';
      }
    } else if (panelType == PanelType.language) {
      if (SoundPageManager.currentLanguage == Language.en) {
        return 'Language';
      } else if (SoundPageManager.currentLanguage == Language.cn) {
        return '語言';
      }
    } else if (panelType == PanelType.about) {
      if (SoundPageManager.currentLanguage == Language.en) {
        return 'About';
      } else if (SoundPageManager.currentLanguage == Language.cn) {
        return '關於';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final manager = Provider.of<SoundPageManager>(context);

    List<Widget> myList = [];
    if (panelType == PanelType.viewButtonType) {
      for (ButtonType value in ButtonType.values) {
        myList.add(CustomDivider());
        myList.add(
          ExpandedItem(
            text: getButtonTypeText(value),
            selected: SoundPageManager.currentButtonType == value,
            onPressed: () {
              manager.changeButtonType(value);
              Navigator.pop(context);
            },
          ),
        );
      }
    } else if (panelType == PanelType.viewOptions) {
      for (ViewType value in ViewType.values) {
        myList.add(CustomDivider());
        myList.add(
          ExpandedItem(
            text: getViewTypeText(value),
            selected: manager.viewType == value,
            onPressed: () {
              manager.changeViewType(value);
              Navigator.pop(context);
            },
          ),
        );
      }
    } else if (panelType == PanelType.buttonOptions) {
      for (ButtonLayoutType value in ButtonLayoutType.values) {
        myList.add(CustomDivider());
        myList.add(
          ExpandedItem(
            text: getButtonLayoutTypeText(value),
            selected: manager.buttonLayoutType == value,
            onPressed: () {
              if(manager.buttonLayoutType == value){
                Navigator.pop(context);
              }
              else{
                manager.buttonLayoutType = value;
                if(value == ButtonLayoutType.stretch){
                  Navigator.pushNamedAndRemoveUntil(
                      context, StretchedSoundPage.routeName, (route) => false);
                }
                else if(value == ButtonLayoutType.wrap){
                  Navigator.pushNamedAndRemoveUntil(
                      context, WrapedSoundPage.routeName, (route) => false);
                }
              }
            },
          ),
        );
      }
    } else if (panelType == PanelType.language) {
      for (Language value in Language.values) {
        myList.add(CustomDivider());
        myList.add(
          ExpandedItem(
            text: getLanguageText(value),
            selected: SoundPageManager.currentLanguage == value,
            onPressed: () {
              manager.changeLanguage(value);
              Navigator.pop(context);
            },
          ),
        );
      }
    } else if (panelType == PanelType.about) {
      myList.add(CustomDivider());
      myList.add(
        ExpandedItem(
          text: getTheAppText(),
          selected: false,
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, AboutAppPage.routeName);
          },
        ),
      );
    }

    buildList() {
      return Column(
        children: myList,
      );
    }

    return ExpandableNotifier(
        child: ScrollOnExpand(
      child: Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: <Widget>[
            ExpandablePanel(
              theme: kExpandableThemeData,
              header: ExpandablePanelHeader(title: panelTypeName(panelType)),
              expanded: buildList(),
            ),
          ],
        ),
      ),
    ));
  }
}
