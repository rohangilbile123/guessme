import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:guessme/src/screens/auth/mobile_sign.dart';
import 'package:guessme/src/screens/auth/otp.dart';
import './src/screens/home_screen.dart';
import './src/screens/game_screen.dart';
import './src/screens/levels.dart';

void main() => runApp(GuessGameApp());

class GuessGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Guess Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/phone': (context) => MyPhone(),
        '/otp': (context) => MyOtp(),
        '/': (context) => HomeScreen(),
        '/game': (context) => GameScreen(),
        '/level': (context) => LevelScreen(),
      },
    );
  }
}
