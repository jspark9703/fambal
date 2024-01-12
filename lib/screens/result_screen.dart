import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String userQuiz = "더 좋아하는 과일은?";
  final answerList = ["딸기", "사과"];
  final firstAnswerUserList = ["엄마", "아빠"];
  final secondAnswerUserList = ["동생", "할머니"];
  final noAnswerUserList = ["할아버지"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
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
                Column(
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Center(child: Text(answerList[0])),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(firstAnswerUserList.join('\n\n')),
                  ],
                ),
                const Text(
                  'VS',
                  style: TextStyle(fontSize: 30.0),
                ),
                Column(
                  children: [
                    Container(
                      height: 100.0,
                      width: 100.0,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Center(child: Text(answerList[1])),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Text(secondAnswerUserList.join('\n\n')),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              '무응답',
              style: TextStyle(fontSize: 17.0),
            ),
            Text(noAnswerUserList.join('\n\n')),
          ],
        ),
      ),
    );
  }
}
