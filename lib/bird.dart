import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  final birdY;

  const MyBird({required this.birdY, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0, birdY),
      child: Image.asset('assets/images/flappy.png', width: 60, height: 60),
    );
  }
}
