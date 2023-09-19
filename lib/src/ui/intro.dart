import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/src/ui/app.dart';

import 'package:lottie/lottie.dart';

class Intro extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: TextLiquidFill(
                text: 'Bienvenue ',
                waveColor: Colors.blueAccent,
                boxBackgroundColor: Colors.white,
                textStyle: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 300.0,
                boxWidth: double.infinity,
              ),
            ),
            Expanded(
              child: AnimatedSplashScreen(
                splash: Lottie.asset("lib/assets/intro.json"),
                splashIconSize: 400,
                nextScreen: MyPage(),
                splashTransition: SplashTransition.scaleTransition,
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                duration: 6000,
              ),
            ),
            GestureDetector(
              child: Expanded(
                child: Container(
                  width: 140,
                  child: Image.asset("lib/assets/logoport.png"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
