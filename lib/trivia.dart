import 'package:flutter/material.dart';

class TriviaPage extends StatefulWidget {
  @override
  _TriviaPageState createState() => _TriviaPageState();
}

class _TriviaPageState extends State<TriviaPage> {
  int _currentQuestionIndex = 0;
  late List<Question> _questions;
  bool _isAnswered = false;
  int _selectedAnswerIndex = -1;
  int _totalCorrectAnswers = 0;

  @override
  void initState() {
    super.initState();
    _questions = _getQuestions();
  }

  List<Question> _getQuestions() {
    return [
      Question(
        question: "What was our first official date in Mauritius?",
        answers: [
          Answer(answerText: "Bowling"),
          Answer(answerText: "Panarottis pizza night"),
          Answer(answerText: "My birthday dinner"),
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        question:
            "What is the one meal you always begged me to make back at school?",
        answers: [
          Answer(answerText: "Wings"),
          Answer(answerText: "Lasagna"),
          Answer(answerText: "Rice and Chicken"),
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        question:
            "What is the one thing I have always asked you to do with me in Mauritius?",
        answers: [
          Answer(answerText: "To go to the beach"),
          Answer(answerText: "To get chicken in Tamarin"),
          Answer(answerText: "To do our work together"),
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        question: "What is the one song we abused in Mauritius?",
        answers: [
          Answer(answerText: "Gangsta"),
          Answer(answerText: "Fxxx"),
          Answer(answerText: "Body"),
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        question: "Which place do we always find ourselves at in Harare?",
        answers: [
          Answer(answerText: "Pomona"),
          Answer(answerText: "Chisi Food Court"),
          Answer(answerText: "Highland Park"),
        ],
        correctAnswerIndex: 2,
      ),
      Question(
        question:
            "What was the thing that you taught me in Mauritius that made us bond a lot?",
        answers: [
          Answer(answerText: "Pool"),
          Answer(answerText: "Wrestling"),
          Answer(answerText: "Fifa"),
          Answer(answerText: "All of the above"),
        ],
        correctAnswerIndex: 3,
      ),
      Question(
        question: "What is the one ice cream flavor I am always talking about?",
        answers: [
          Answer(answerText: "Mango and Raspberry"),
          Answer(answerText: "Strawberry Cheesecake"),
          Answer(answerText: "Tin Roof"),
          Answer(answerText: "I am not sure"),
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        question: "What do I think is your best quality?",
        answers: [
          Answer(answerText: "Your loyalty"),
          Answer(answerText: "The way you love hard"),
          Answer(answerText: "Your generosity"),
          Answer(answerText: "Your humor"),
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        question: "What is my favorite pet name for you?",
        answers: [
          Answer(answerText: "Sthandwa Sami"),
          Answer(answerText: "Babe"),
          Answer(answerText: "Baby"),
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        question:
            "What is the one car brand we have spoken about getting when we are older?",
        answers: [
          Answer(answerText: "Lamborghini"),
          Answer(answerText: "Range Rover"),
          Answer(answerText: "Mercedes Benz"),
          Answer(answerText: "All of the above!"),
        ],
        correctAnswerIndex: 0,
      ),
    ];
  }

  void _checkAnswer(int index) {
    setState(() {
      _isAnswered = true;
      _selectedAnswerIndex = index;
      if (_questions[_currentQuestionIndex].correctAnswerIndex == index) {
        _totalCorrectAnswers++;
      }
      Future.delayed(Duration(seconds: 1), () {
        setState(() {
          _currentQuestionIndex++;
          _isAnswered = false;
          _selectedAnswerIndex = -1;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentQuestionIndex >= _questions.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Trivia Game'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'You completed the quiz! You got $_totalCorrectAnswers out of ${_questions.length} correct.'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _currentQuestionIndex = 0;
                    _totalCorrectAnswers = 0;
                  });
                },
                child: Text('Restart Quiz'),
              ),
            ],
          ),
        ),
      );
    }

    Question currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Our Love Trivia Game'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  currentQuestion.question,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 121, 170, 210),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children:
                      currentQuestion.answers.asMap().entries.map((entry) {
                    int index = entry.key;
                    Answer answer = entry.value;
                    Color buttonColor = _isAnswered
                        ? (index == currentQuestion.correctAnswerIndex
                            ? Colors.green
                            : (index == _selectedAnswerIndex
                                ? Colors.red
                                : Colors.grey))
                        : Color.fromARGB(255, 136, 166, 191);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ElevatedButton(
                        onPressed:
                            !_isAnswered ? () => _checkAnswer(index) : null,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 24),
                          backgroundColor: buttonColor,
                        ),
                        child: Text(
                          answer.answerText,
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Question {
  final String question;
  final List<Answer> answers;
  final int correctAnswerIndex;

  Question({
    required this.question,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

class Answer {
  final String answerText;

  Answer({required this.answerText});
}
