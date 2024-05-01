import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:game_2048/Username_input.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () => _goToHomePage(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width *
                    0.8, // 80% of screen width
                height: MediaQuery.of(context).size.height *
                    0.4, // 40% of screen height
                color: Colors.black,
                child: Center(
                  child: Center(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        FadeAnimatedText(
                          '2048',
                          textStyle: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                          duration: const Duration(milliseconds: 3000),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(
                bottom: 16.0),
            child: Text(
              "Made by Nikhil Beldar",
              style: TextStyle(fontSize: 20,color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _goToHomePage(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => UsernameInput(),
      ),
    );
  }
}
