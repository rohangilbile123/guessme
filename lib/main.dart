import 'package:flutter/material.dart';
import './src/screens/home_screen.dart';
import './src/screens/game_screen.dart';

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
        '/': (context) => HomeScreen(),
        '/game': (context) => GameScreen(),
      },
    );
  }
}
