import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';


import 'pages/StretchedSoundPage.dart';
import 'providers/soundPageManager.dart';
import 'pages/WrapedSoundPage.dart';
import 'providers/LayoutFinder.dart';
import 'pages/AppAboutPage.dart';

import 'package:sound_button_beta/ExpandableTest.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SoundPageManager(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          buttonColor: Colors.purpleAccent,
        ),
        initialRoute: StretchedSoundPage.routeName,
        routes: {
          StretchedSoundPage.routeName: (context) => StretchedSoundPage(),
          ExpandableExample.routeName: (context) => ExpandableExample(),
          WrapedSoundPage.routeName: (context) => WrapedSoundPage(),
          LayoutWidget.routeName: (context) => LayoutWidget(),
          AboutAppPage.routeName: (context) => AboutAppPage(),
        },
      ),
    );
  }
}


//SoundPage(title: 'Sound Board beta'),