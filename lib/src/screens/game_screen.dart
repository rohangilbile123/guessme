import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/api_service.dart';
import 'dart:async';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  ApiService _apiService = ApiService();
  late Timer _timer;
  int _timerDuration = 10;
  bool _isLoadingNextQuestion = false;
  @override
  void initState() {
    super.initState();
    _fetchQuestions();
    _startTimer();
  }

  void _fetchQuestions() async {
    List<Question> questions = await _apiService.getQuestions();
    setState(() {
      _questions = questions;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timerDuration > 0) {
          _timerDuration--;
        } else {
          _isLoadingNextQuestion = true;
          _timer.cancel();
          _showNextQuestion();
        }
      });
    });
  }

  void _checkAnswer(String selectedOption) {
    Question currentQuestion = _questions[_currentQuestionIndex];
    if (!_isLoadingNextQuestion) {
      setState(() {
        _isLoadingNextQuestion = true;
        _timer.cancel();
        if (selectedOption == currentQuestion.answer) {
          _score++;
        }
        _showNextQuestion();
      });
    }
  }

  void _showNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _timerDuration = 10;
        _isLoadingNextQuestion = false;
        _startTimer();
      });
    } else {
      _timer.cancel();
      Navigator.pop(context, _score);
      // showDialog(
      //   context: context,
      //   builder: (BuildContext context) {
      //     return AlertDialog(
      //       title: Text('Game Over'),
      //       content: Text('Your score: $_score'),
      //       actions: [
      //         TextButton(
      //           onPressed: () {
      //             Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
      //           },
      //           child: Text('Continue to Home'),
      //         ),
      //         TextButton(
      //           onPressed: () {
      //             setState(() {
      //               _currentQuestionIndex = 0;
      //               _score = 0;
      //               _timerDuration = 10;
      //               _isLoadingNextQuestion = false;
      //             });
      //             _startTimer();
      //             Navigator.pop(context);
      //           },
      //           child: Text('Retake Quiz'),
      //         ),
      //       ],
      //     );
      //   },
      // );
    }
  }

  Widget _buildOptionsList() {
    Question currentQuestion = _questions[_currentQuestionIndex];
    return Column(
      children: currentQuestion.options.map((option) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {
              _checkAnswer(option);
            },
            child: Text(option),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess Game'),
      ),
      body: _questions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 16.0),
                  Text(
                    _questions[_currentQuestionIndex].questionText,
                    style: TextStyle(fontSize: 24.0),
                  ),
                  SizedBox(height: 16.0),
                  _buildOptionsList(),
                  SizedBox(height: 16.0),
                  Text(
                    'Score: $_score',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Timer: $_timerDuration',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ],
              ),
            ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
