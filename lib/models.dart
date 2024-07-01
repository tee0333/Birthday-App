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
