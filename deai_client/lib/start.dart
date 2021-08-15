import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AnimatedText/animatedText.dart';
import '../AnimatedText/typwriter.dart';
import 'Constants/constraints.dart';
import 'Constants/strings.dart';

class Start extends StatelessWidget {
  Start({Key? key}) : super(key: key);

  ButtonStyle buttonStyle1 = ElevatedButton.styleFrom(
    primary: Colors.transparent,
    elevation: 0,
    onSurface: Colors.transparent,
  );

  final TextStyle textStyle0 = GoogleFonts.nixieOne(
    textStyle: TextStyle(color: Colors.white60, fontSize: 20),
  );

  final TextStyle textStyle1 = GoogleFonts.nixieOne(
    textStyle: TextStyle(color: Color.fromRGBO(85, 90, 100, 1), fontSize: 20),
  );

  final TextStyle textStyle2 = GoogleFonts.nixieOne(
    textStyle: TextStyle(color: Colors.white, fontSize: 24),
  );

  final TextStyle textStyle3 = GoogleFonts.nixieOne(
    textStyle: TextStyle(
      color: Color.fromRGBO(85, 90, 100, 1),
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    ),
  );

  final TextStyle textStyle4 = GoogleFonts.nixieOne(
    textStyle: TextStyle(
      color: Colors.blue,
      fontSize: 28.0,
      fontWeight: FontWeight.bold,
    ),
  );

  final Gradient linearGradient = LinearGradient(
      colors: <Color>[Colors.blue, Colors.lightBlue.shade200, Colors.blue],
      stops: [0.1, .7, 1]);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kBoxDecoration,
      child: Scaffold(
        appBar: AppBar(
          title:
              Text("Decentralised Artificial Intelligence", style: textStyle0),
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 50,
          actions: [
            Container(
              width: 400,
              margin: EdgeInsets.only(right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () => null,
                      child: Text(
                        "Explore",
                        style: textStyle1,
                      ),
                      style: buttonStyle1),
                  ElevatedButton(
                    onPressed: () =>
                        Navigator.pushNamedAndRemoveUntil(context, DASHBOARD_SCREEN, (route) => false),
                    child: Text("Dashboard", style: textStyle1),
                    style: buttonStyle1,
                  ),
                  ElevatedButton(
                    onPressed: () => null,
                    child: Text("Docs", style: textStyle1),
                    style: buttonStyle1,
                  ),
                  Icon(
                    Icons.light,
                    color: Color.fromRGBO(85, 90, 100, 1),
                  )
                ],
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(children: [
            SizedBox(height: 200),
            Container(
              padding: EdgeInsets.all(1),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.red],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.blue,
                        blurRadius: 5,
                        offset: Offset(-3, 0)),
                    BoxShadow(
                      color: Colors.red,
                      blurRadius: 5,
                      offset: Offset(3, 1),
                    )
                  ]),
              child: ElevatedButton(
                onPressed: () => null,
                child: Text(
                  "DeAi is now live ✨",
                  style: textStyle2,
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            SizedBox(height: 20),
            Text("The Decentralized",
                style: GoogleFonts.squadaOne(
                  textStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 84,
                  ),
                )),
            Container(
              child: ShaderMask(
                shaderCallback: (bounds) => linearGradient.createShader(
                  Rect.fromLTWH(-100, 0, bounds.width, bounds.height),
                ),
                child: Text(
                  "Artificial Intelligence",
                  style: GoogleFonts.squadaOne(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 132,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "of Modern Times",
              style: GoogleFonts.squadaOne(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 84,
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Machine Learning models available for ",
                  style: textStyle3,
                ),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Sentiment Analysis,',
                      textStyle: textStyle4,
                      speed: const Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'Image Classification,',
                      textStyle: textStyle4,
                      speed: const Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'Face Recognition,',
                      textStyle: textStyle4,
                      speed: const Duration(milliseconds: 100),
                    ),
                    TypewriterAnimatedText(
                      'Voice Analysis',
                      textStyle: textStyle4,
                      speed: const Duration(milliseconds: 100),
                    )
                  ],
                  repeatForever: true,
                ),
                // Text(
                //   "now ",
                //   style: textStyle3,
                // ),
              ],
            ),
            Text(
              "for communities accross all over the world.",
              style: textStyle3,
            ),
          ]),
        ),
      ),
    );
  }
}
