import 'package:flutter/material.dart';
import '../models/question.dart';
import '../services/api_service.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<Question> _questions = [];
  int _currentQuestionIndex = 0;
  int _score = 0;
  ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  void _fetchQuestions() async {
    List<Question> questions = await _apiService.getQuestions();
    setState(() {
      _questions = questions;
    });
  }

  void _checkAnswer(String selectedOption) {
    Question currentQuestion = _questions[_currentQuestionIndex];
    if (selectedOption == currentQuestion.answer) {
      setState(() {
        _score++;
      });
    }
    _showNextQuestion();
  }

  void _showNextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Handle end of the game
      // You can navigate to a score screen or show a dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Game Over'),
            content: Text('Your score: $_score'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
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
                  Text(
                    'Category: ${_questions[_currentQuestionIndex].category}',
                    style: TextStyle(fontSize: 18.0),
                  ),
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
                ],
              ),
            ),
    );
  }
}
