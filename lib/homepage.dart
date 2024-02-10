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
  double height = 0;
  double velocity = 3.5;
  double gravity = -4.9;
  double time = 0;

  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 100), (timer) {
      height = gravity * time * time + velocity * time;

      setState(() {
        birdY = initialPos - height;
      });
      print(birdY);

      time += 0.1;
      if (gameOver()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }
    });
  }

  void reset() {
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      time = 0;
      gameHasStarted = false;
      birdY = initialPos;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.green,
            title: const Center(
              child: Text(
                "Game Over!",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              GestureDetector(
                onTap: reset,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    color: Colors.brown,
                    child: const Text(
                      'P L A Y   A G A I N',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
    });
  }

  bool gameOver() {
    if (birdY < -1 || birdY > 1) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Stack(
                  children: [
                    MyBird(birdY: birdY),
                    Container(
                      alignment: const Alignment(0, -0.5),
                      child: Text(
                        gameHasStarted ? '' : 'T A P  T O  P L A Y',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
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
