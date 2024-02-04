import 'dart:async';

import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  static double birdY = 0;
  double initialPos = birdY;

  void birdJump() {
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        birdY -= 0.05;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: birdJump,
      child: Scaffold(
        body: Column(children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Stack(children: [MyBird(birdY: birdY)]),
              ),
            ),
          ),
          Expanded(
            child: Container(color: Colors.green),
          )
        ]),
      ),
    );
  }
}
