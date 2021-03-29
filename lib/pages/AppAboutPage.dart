import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutAppPage extends StatelessWidget {
  static const routeName = 'AboutAppPageRoute';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SoundBoard Beta'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.026),
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 1 / 3,
                backgroundImage: AssetImage("assets/images/pusheen.jpg"),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(color: Colors.white),
                ),
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'This App is developed by TiTi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'TiTi hopes that someday his brain will grow bigger, because big brains are tasty. Until you get infected by Kuru, in which case you\'ll die.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'yay! :D',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                    text: 'Twitter',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25.0,
                      decoration: TextDecoration.underline,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        launch(
                            'https://twitter.com/TiTi32984017');
                      }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
