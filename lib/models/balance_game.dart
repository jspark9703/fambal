class BalanceQuestion {
  String balanceQuestion;
  List<String> balanceAnswers;
  int balanceAnsCode;

  BalanceQuestion({
    required this.balanceQuestion,
    required this.balanceAnswers,
    required this.balanceAnsCode,
  });

  factory BalanceQuestion.fromJson(Map<String, dynamic> json) {
    List<dynamic> answersJson = json['balance_answers'];
    List<String> answers = answersJson.cast<String>().toList();

    return BalanceQuestion(
      balanceQuestion: json['balance_question'],
      balanceAnswers: answers,
      balanceAnsCode: json['balance_ans_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'balance_question': balanceQuestion,
      'balance_answers': balanceAnswers,
      'balance_ans_code': balanceAnsCode,
    };
  }
}


// BalanceQuestion question = BalanceQuestion(
//   balanceQuestion: "What is the meaning of life?",
//   balanceAnswers: ["To be happy", "42"],
//   balanceAnsCode: 456,
// );

// // 객체를 JSON으로 변환
// Map<String, dynamic> questionJson = question.toJson();

// // JSON을 객체로 변환
// BalanceQuestion questionFromJson = BalanceQuestion.fromJson(questionJson);