import 'package:cloud_firestore/cloud_firestore.dart';

class BalanceQuiz {
  String balanceQuestion;
  String leftAnswer;
  int leftCorrect;
  String rightAnswer;
  int rightCorrect;
  int balanceNum;
  int balanceAnsCode;
  String familyCode;
  String userName;

  BalanceQuiz(
      {required this.balanceQuestion,
      required this.leftAnswer,
      required this.leftCorrect,
      required this.rightAnswer,
      required this.rightCorrect,
      required this.balanceNum,
      required this.balanceAnsCode,
      required this.familyCode,
      required this.userName});

  factory BalanceQuiz.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return BalanceQuiz(
        balanceQuestion: data?['balance_question'],
        leftAnswer: data?['left_answer'],
        leftCorrect: data?['left_correct'],
        rightAnswer: data?['right_answer'],
        rightCorrect: data?['right_correct'],
        balanceNum: data?['balance_num'],
        balanceAnsCode: data?['balance_ans_code'],
        familyCode: data?["family_code"],
        userName: data?["user_name"]);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "balance_question": balanceQuestion,
      "left_answer": leftAnswer,
      "left_correct": leftCorrect,
      "right_answer": rightAnswer,
      "right_correct": rightCorrect,
      "balance_num": balanceNum,
      "balance_ans_code": balanceAnsCode,
      "family_code": familyCode,
      "user_name": userName
    };
  }
}
