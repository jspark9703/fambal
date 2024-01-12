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

class BalanceQuestion {
  String balanceQuestion;
  List<BalanceAnswer> balanceAnswers;
  int balanceNum;
  int balanceAnsCode;

  BalanceQuestion({
    required this.balanceQuestion,
    required this.balanceAnswers,
    required this.balanceNum,
    required this.balanceAnsCode,
  });

  factory BalanceQuestion.fromJson(Map<String, dynamic> json) {
    List<dynamic> answersJson = json['balance_answers'];
    List<BalanceAnswer> answers =
        answersJson.map((ans) => BalanceAnswer.fromJson(ans)).toList();

    return BalanceQuestion(
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
