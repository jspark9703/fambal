import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackton_project/models/balance_quiz.dart';
import 'package:hackton_project/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class BalanceScreen extends StatefulWidget {
  const BalanceScreen({super.key});

  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  String selectedButton = ''; // 선택된 버튼
  String question = ''; // 서버에서 받아온 질문
  List<String> balanceGames = []; // 서버에서 받아온 밸런스 게임 목록
  final db = FirebaseFirestore.instance;
  // Example data for BalanceAnswer
  // Example data for BalanceQuiz with two answers
  BalanceQuiz balanceQuiz = BalanceQuiz(
      balanceQuestion: "아들의 생일이 속한 달은?",
      leftAnswer: "8월",
      leftCorrect: 0,
      rightAnswer: "3월",
      rightCorrect: 1,
      balanceNum: 1,
      balanceAnsCode: 0,
      familyCode: "",
      userName: "");

  @override
  void initState() {
    super.initState();
    // initState에서 서버에서 데이터를 가져오는 함수 호출
  }

  // 서버에서 데이터를 가져오는 비동기 함수
  Future<void> fetchDataFromServer() async {
    try {
      // 실제 서버의 URL로 수정
      final response = await http.get(Uri.parse(''));

      if (response.statusCode == 200) {
        // 서버에서 데이터를 성공적으로 가져온 경우
        final Map<String, dynamic> jsonData = json.decode(response.body);
        setState(() {
          question = jsonData['question'];
          balanceGames = List<String>.from(jsonData['balanceGames']);
        });
      } else {
        // 서버에서 데이터를 가져오지 못한 경우
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // 오류 발생 시
      print('Error: $error');
    }
  }

  // 선택된 버튼을 서버에 전송하는 비동기 함수

  int rannum = 0;

  @override
  Widget build(BuildContext context) {
    db.collection("balance_list").get().then((value) {
      rannum = Random().nextInt(value.docs.length);
    });

    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 243, 221, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(252, 243, 221, 1),
        title: const Text(""),
        actions: const <Widget>[],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 70), // 여유 공간 추가
              Center(
                child: Container(
                  alignment: Alignment.center,
                  width: 340,
                  height: 400,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: ContinuousRectangleBorder(),
                  ),
                  child: FutureBuilder<QuerySnapshot>(
                      future: db.collection("balance_list").get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child:
                                  CircularProgressIndicator()); // Display a loading indicator while fetching data.
                        }

                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                          return const Text('No comments available.');
                        }

                        var dataList = [];
                        dataList = snapshot.data!.docs;

                        return Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 340,
                              height: 50,
                              decoration: const ShapeDecoration(
                                color: Colors.orange,
                                shape: ContinuousRectangleBorder(),
                              ),
                              child: const Text("밸런스 게임",
                                  style: TextStyle(fontSize: 20)),
                            ),
                            Text(
                              dataList[rannum]["question"], // 서버에서 받아온 질문 표시
                              style: const TextStyle(fontSize: 25),
                            ),
                            const SizedBox(height: 100), // 여유 공간 추가
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {
                                    selectedButton = 'left'; // 왼쪽 버튼 선택
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedButton == 'left'
                                        ? Colors.green
                                        : null,
                                  ),
                                  child: Text(
                                    dataList[rannum]
                                        ["left_answer"], // 서버에서 받아온 밸런스 게임 표시
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Text(
                                    "Vs",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    selectedButton = 'right'; // 오른쪽 버튼 선택
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: selectedButton == 'right'
                                        ? Colors.blue
                                        : null,
                                  ),
                                  child: Text(
                                    dataList[rannum]
                                        ["right_answer"], // 서버에서 받아온 밸런스 게임 표시
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            )
                          ],
                        );
                      }),
                ),
              ),
              const SizedBox(height: 100),
              Consumer<UserProviderR>(builder: (context, userprovider, _) {
                return FutureBuilder(
                    future: db.collection("balance_list").get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child:
                                CircularProgressIndicator()); // Display a loading indicator while fetching data.
                      }

                      if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }

                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return const Text('No comments available.');
                      }

                      var dataList = [];
                      dataList = snapshot.data!.docs;

                      return SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: () {
                            // 선택된 버튼에 따라 다른 동작 수행
                            if (selectedButton == 'left') {
                              // 왼쪽 버튼 선택 시 동작

                              setState(() {
                                balanceQuiz = BalanceQuiz(
                                    balanceQuestion: dataList[rannum]
                                        ["question"],
                                    leftAnswer: dataList[rannum]["left_answer"],
                                    leftCorrect: 1,
                                    rightAnswer: dataList[rannum]
                                        ["right_answer"],
                                    rightCorrect: 0,
                                    balanceNum: 0,
                                    balanceAnsCode: 0,
                                    familyCode: userprovider.familyCode!,
                                    userName: userprovider.userName);
                              });
                              try {
                                db
                                    .collection("balance_game")
                                    .doc()
                                    .set(balanceQuiz.toFirestore());
                              } catch (e) {
                                print(e);
                              }

                              GoRouter.of(context).goNamed("home");
                            } else if (selectedButton == 'right') {
                              // 오른쪽 버튼 선택 시 동작

                              setState(() {
                                balanceQuiz = BalanceQuiz(
                                    userName: userprovider.userName,
                                    balanceQuestion: dataList[rannum]
                                        ["question"],
                                    leftAnswer: dataList[rannum]["left_answer"],
                                    leftCorrect: 0,
                                    rightAnswer: dataList[rannum]
                                        ["right_answer"],
                                    rightCorrect: 1,
                                    balanceNum: 0,
                                    balanceAnsCode: 0,
                                    familyCode: userprovider.familyCode!);
                              });
                            }
                            db
                                .collection("balance_game")
                                .doc()
                                .set(balanceQuiz.toFirestore());
                            // 선택된 버튼을 서버에 전송
                            userprovider.setState = 1;

                            // try {
                            //   db
                            //       .collection("user")
                            //       .doc(userprovider.familyCode)
                            //       .set(userprovider.toJson());
                            // } catch (e) {
                            //   print(e);
                            // }
                            try {
                              db
                                  .collection("balance_game")
                                  .doc(userprovider.familyCode)
                                  .set(balanceQuiz.toFirestore());
                            } catch (e) {
                              print(e);
                            }

                            GoRouter.of(context).goNamed("home"); // 라우터로 페이지 이동
                          },
                          child: const Text("완료",
                              style: TextStyle(color: Colors.black)),
                        ),
                      );
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
