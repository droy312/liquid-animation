import 'dart:async';

import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Liquid Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LiquidAnimation(),
    );
  }
}

class LiquidAnimation extends StatefulWidget {
  @override
  _LiquidAnimationState createState() => _LiquidAnimationState();
}

class _LiquidAnimationState extends State<LiquidAnimation>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;
  bool isAnimation = false;

  static Color black = Color.fromRGBO(45, 45, 45, 1);
  Color flowColor = black;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          children: [
            TweenAnimationBuilder(
              curve: Curves.fastOutSlowIn,
              tween: Tween<double>(begin: isAnimation ? 1.1 : 0, end: isAnimation ? 1.1 : 0),
              duration: Duration(milliseconds: 4000),
              builder: (_, val, __) => LiquidLinearProgressIndicator(
                value: val,
                direction: Axis.vertical,
                backgroundColor: Colors.transparent,
                valueColor: AlwaysStoppedAnimation(black),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  isAnimation = !isAnimation;
                  Timer(Duration(milliseconds: 1200), () {
                    setState(() {
                      isPressed = !isPressed;
                    });
                  });
                });
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                alignment: Alignment.center,
                child: Text(
                  'Flow',
                  style: TextStyle(
                    color: isPressed ? Colors.white : black,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
