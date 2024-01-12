import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackton_project/provider/firebase_auth.dart';
import 'package:hackton_project/widgets/common/app_bar_auth.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String userName = "OO";
  String userQuiz = "더 좋아하는 과일은?";
  String rightAnswer = "사과";
  final answerList = ["딸기", "사과"];

  void quizResultDialog(bool isCorrect) {
    showDialog(
        context: context,
        barrierDismissible: false, //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        builder: (BuildContext context) {
          if (isCorrect) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              //Dialog Main Title
              title: const SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "오늘의 퀴즈 결과는...",
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ],
                ),
              ),
              //
              content: const SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("성공", style: TextStyle(fontSize: 25.0)),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("확인"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          } else {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              //Dialog Main Title
              title: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "오늘의 퀴즈 결과는...",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ],
              ),
              //
              content: const SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("실패", style: TextStyle(fontSize: 25.0)),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("확인"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fambal"), actions: [
        Consumer<ApplicationState>(
          builder: (context, appState, _) => AuthFunc(
              loggedIn: appState.loggedIn,
              signOut: () {
                FirebaseAuth.instance.signOut();
              }),
        ),
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              '$userName의 질문',
              style: const TextStyle(fontSize: 15.0),
            ),
            Text(
              userQuiz,
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    bool isCorrect = false;
                    if (answerList[0] == rightAnswer) isCorrect = true;
                    quizResultDialog(isCorrect);
                  },
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Center(child: Text(answerList[0])),
                  ),
                ),
                const Text(
                  'VS',
                  style: TextStyle(fontSize: 30.0),
                ),
                GestureDetector(
                  onTap: () {
                    bool isCorrect = false;
                    if (answerList[1] == rightAnswer) isCorrect = true;
                    quizResultDialog(isCorrect);
                  },
                  child: Container(
                    height: 100.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1)),
                    child: Center(child: Text(answerList[1])),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
