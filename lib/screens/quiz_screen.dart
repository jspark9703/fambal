import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackton_project/models/user.dart';
import 'package:hackton_project/provider/firebase_auth.dart';
import 'package:hackton_project/widgets/common/app_bar_auth.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final db = FirebaseFirestore.instance;

  void quizResultDialog(bool isCorrect) {
    showDialog(
        context: context,
        barrierDismissible: false, //barrierDismissible - Dialog를 제외한 다른 화면 터치 x
        builder: (BuildContext context) {
          if (isCorrect) {
            return Consumer<UserProviderR>(builder: (context, _, __) {
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
                      context.goNamed("home");
                      _.setPoint = _.userPoint + 10;
                    },
                  ),
                ],
              );
            });
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
                    context.goNamed("home");
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
      appBar: AppBar(
        title: const Text("Fambal"),
        actions: [
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
              loggedIn: appState.loggedIn,
              signOut: () {
                FirebaseAuth.instance.signOut();
              },
            ),
          ),
        ],
      ),
      body: Consumer<UserProviderR>(
        builder: (context, userProvider, _) {
          return FutureBuilder<QuerySnapshot>(
            future: db
                .collection("balance_game")
                .where("family_code", isEqualTo: userProvider.familyCode)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          '가족들의 선택은 무엇이었을까요?',
                          style: TextStyle(fontSize: 15.0),
                        ),
                        const Text(
                          "가족들을 사랑하시나요?",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                bool isCorrect = true;
                                quizResultDialog(isCorrect);
                              },
                              child: Container(
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent[100],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "예",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              'VS',
                              style: TextStyle(fontSize: 30.0),
                            ),
                            GestureDetector(
                              onTap: () {
                                bool isCorrect = true;
                                quizResultDialog(isCorrect);
                              },
                              child: Container(
                                height: 100.0,
                                width: 100.0,
                                decoration: BoxDecoration(
                                  color: Colors.orangeAccent[100],
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: const Center(
                                  child: Text(
                                    "예",
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }

                var data = snapshot.data!.docs[0];
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '${data["user_name"]}의 선택은 무엇이었을까요?',
                        style: const TextStyle(fontSize: 15.0),
                      ),
                      Text(
                        data["balance_question"],
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
                              bool isCorrect = data["left_correct"] == 1;
                              quizResultDialog(isCorrect);
                            },
                            child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent[100],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  data["left_answer"],
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            'VS',
                            style: TextStyle(fontSize: 30.0),
                          ),
                          GestureDetector(
                            onTap: () {
                              bool isCorrect = data["right_correct"] == 1;
                              quizResultDialog(isCorrect);
                            },
                            child: Container(
                              height: 100.0,
                              width: 100.0,
                              decoration: BoxDecoration(
                                color: Colors.orangeAccent[100],
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  data["right_answer"],
                                  style: const TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
