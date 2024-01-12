class BalanceAnswer {
  String answer;
  int correct;

  BalanceAnswer({
    required this.answer,
    required this.correct,
  });

  factory BalanceAnswer.fromJson(Map<String, dynamic> json) {
    return BalanceAnswer(
      answer: json['answer'],
      correct: json['correct'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'correct': correct,
    };
  }
}

class BalanceQuiz {
  String balanceQuestion;
  List<BalanceAnswer> balanceAnswers;
  int balanceNum;
  int balanceAnsCode;

  BalanceQuiz({
    required this.balanceQuestion,
    required this.balanceAnswers,
    required this.balanceNum,
    required this.balanceAnsCode,
  });

  factory BalanceQuiz.fromJson(Map<String, dynamic> json) {
    List<dynamic> answersJson = json['balance_answers'];
    List<BalanceAnswer> answers =
        answersJson.map((ans) => BalanceAnswer.fromJson(ans)).toList();

    return BalanceQuiz(
      balanceQuestion: json['balance_question'],
      balanceAnswers: answers,
      balanceNum: json['balance_num'],
      balanceAnsCode: json['balance_ans_code'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> answersJson =
        balanceAnswers.map((ans) => ans.toJson()).toList();

    return {
      'balance_question': balanceQuestion,
      'balance_answers': answersJson,
      'balance_num': balanceNum,
      'balance_ans_code': balanceAnsCode,
    };
  }
}

//사용
// BalanceQuestion question = BalanceQuestion(
//   balanceQuestion: "What is the meaning of life?",
//   balanceAnswers: [
//     BalanceAnswer(answer: "To be happy", correct: 1),
//     BalanceAnswer(answer: "42", correct: 0),
//   ],
//   balanceNum: 123,
//   balanceAnsCode: 456,
// );FEFAF1

// // 객체를 JSON으로 변환
// Map<String, dynamic> questionJson = question.toJson();

// // JSON을 객체로 변환
// BalanceQuestion questionFromJson = BalanceQuestion.fromJson(questionJson);