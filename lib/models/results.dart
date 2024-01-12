class QuizQuestion {
  String question;
  List<String> questionAnswers;
  int balanceAnsCode;

  QuizQuestion({
    required this.question,
    required this.questionAnswers,
    required this.balanceAnsCode,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    List<dynamic> answersJson = json['question_answers'];
    List<String> answers = answersJson.cast<String>().toList();

    return QuizQuestion(
      question: json['question'],
      questionAnswers: answers,
      balanceAnsCode: json['balance_ans_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'question_answers': questionAnswers,
      'balance_ans_code': balanceAnsCode,
    };
  }
}


// // Example data creation
// QuizQuestion quizQuestion = QuizQuestion(
//   question: "What is the capital of France?",
//   questionAnswers: ["Paris", "Berlin", "Madrid", "London"],
//   balanceAnsCode: 123,
// );

// // Convert object to JSON
// Map<String, dynamic> questionJson = quizQuestion.toJson();

// // Convert JSON to object
// QuizQuestion questionFromJson = QuizQuestion.fromJson(questionJson);