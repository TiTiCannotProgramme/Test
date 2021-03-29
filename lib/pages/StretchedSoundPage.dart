import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';

import '../providers/constants.dart';
import '../blueprints/stretchedSoundButton.dart';
import '../providers/soundPageManager.dart';
import '../blueprints/buttonInfo.dart';
import '../blueprints/invisibleButton.dart';
import '../blueprints/changePageButton.dart';
import '../blueprints/customDrawer.dart';
import '../blueprints/BottomPageChanger.dart';
import '../providers/LayoutFinder.dart';

class StretchedSoundPage extends StatefulWidget {
  static const routeName = 'StretchedSoundPageRoute';

  @override
  _StretchedSoundPageState createState() => _StretchedSoundPageState();
}

class _StretchedSoundPageState extends State<StretchedSoundPage>
    with SingleTickerProviderStateMixin{
  AnimationController _animationController;
  GlobalKey bottomKey = GlobalKey();

  @override
  void initState() {
    //WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
    SoundPageManager.getMaxPageNumber(ButtonLayoutType.stretch, SoundPageManager.currentButtonType);
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

  // _afterLayout(_){
  //   LayoutFinder.findSize(context);
  // }

  @override
  void dispose() {
    SoundPageManager.assetsAudioPlayer.stop();
    _animationController.dispose();
    super.dispose();
  }

  void _afterLayout() {
    _getBottomChangerHeight();
    LayoutFinder.bottomHeightDetermined = true;
    print('bottomHeight is determined');
  }

  void _getBottomChangerHeight() {
    final RenderBox renderBoxBottom =
    bottomKey.currentContext.findRenderObject();
    final bottomHeight = renderBoxBottom.size.height;
    print('bottom button height is $bottomHeight');
    LayoutFinder.bottomButtonHeight = bottomHeight;
  }



  void stopCurrentSoundAndAnimation() {
    _animationController.stop();
    _animationController.reset();
    SoundPageManager.assetsAudioPlayer.stop();
  }

  Widget singleSoundButton(ButtonInfo buttonInfo) {
    return StretchedSoundButton(
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

  List<Widget> buildPageViewSoundButtons(ButtonType buttonType) {
    List<Widget> myButtons = [];
    int x = (SoundPageManager.currentPageNumber - 1) * kMaxButtonsPerPage;
    if (SoundPageManager.currentPageNumber < SoundPageManager.maxPageNumber) {
      int y = x + kMaxButtonsPerPage;
      for (int i = x; i < y; i++) {
        myButtons.add(
          Expanded(
            flex: kSoundButtonFlexValue,
            child: singleSoundButton(SoundPageManager.sortButtonInfoMap()[buttonType][i]),
          ),
        );
      }
      return myButtons;
    } else {
      int y = SoundPageManager.sortButtonInfoMap()[buttonType].length;
      for (int i = x; i < y; i++) {
        myButtons.add(
          Expanded(
            flex: kSoundButtonFlexValue,
            child: singleSoundButton(SoundPageManager.sortButtonInfoMap()[buttonType][i]),
          ),
        );
      }
      int z = myButtons.length;
      for (int i = z; i < kMaxButtonsPerPage; i++) {
        myButtons.add(
          Expanded(
            flex: kSoundButtonFlexValue,
            child: InvisibleButton(),
          ),
        );
      }
      return myButtons;
    }
  }

  Widget buildPageView(ButtonType buttonType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 3.0,
        ),
        ...buildPageViewSoundButtons(buttonType),
        BottomPageChanger(
          key: bottomKey,
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

  Widget buildListView(ButtonType buttonType) {
    return ListView.builder(
      itemCount: SoundPageManager.sortButtonInfoMap()[buttonType].length,
      itemBuilder: (context, index) {
        return singleSoundButton(SoundPageManager.sortButtonInfoMap()[buttonType][index]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //LayoutFinder.findSize(context);
    final manager = Provider.of<SoundPageManager>(context);
    if(LayoutFinder.bottomHeightDetermined == false){
      WidgetsBinding.instance.addPostFrameCallback((_) => _afterLayout());
    }
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
              padding: const EdgeInsets.all(0.0),
              splashRadius: 0.1,
              icon: Icon(
                Icons.stop_circle_outlined,
                color: Theme.of(context).errorColor.withOpacity(0.7),
                size: kToolbarHeight/1.5,
              ),
              onPressed: () {
                stopCurrentSoundAndAnimation();
              },
            ),
          ),
        ],
      ),
      body: Center(
        child: manager.viewType == ViewType.listView
            ? buildListView(SoundPageManager.currentButtonType)
            : buildPageView(SoundPageManager.currentButtonType),
      ),
    );
  }
}
