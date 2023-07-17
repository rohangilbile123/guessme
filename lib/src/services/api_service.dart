import '../models/question.dart';

class ApiService {
  Future<List<Question>> getQuestions() async {
    // Implement the logic to fetch a list of questions from the REST API
    // Return a List of Question objects based on the retrieved data

    // For now, we'll return a sample list of questions
    return Future.delayed(Duration(seconds: 2), () {
      return [
        Question(
          category: 'Person',
          questionText: 'Who is the founder of SpaceX?',
          answer: 'Elon Musk',
          options: [
            'Elon Musk',
            'Jeff Bezos',
            'Richard Branson',
            'Mark Zuckerberg',
          ],
          difficultyLevel: 'Medium',
        ),
        Question(
          category: 'Animal',
          questionText: 'Which animal is known as the "king of the jungle"?',
          answer: 'Lion',
          options: [
            'Lion',
            'Tiger',
            'Leopard',
            'Cheetah',
          ],
          difficultyLevel: 'Easy',
        ),
        // Add more questions here...
      ];
    });
  }
}
