import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackton_project/models/user.dart';
import 'package:hackton_project/provider/firebase_auth.dart';
import 'package:hackton_project/widgets/common/app_bar_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeBalanceScreen extends StatefulWidget {
  const HomeBalanceScreen({super.key});

  @override
  _HomeBalanceScreenState createState() => _HomeBalanceScreenState();
}

class _HomeBalanceScreenState extends State<HomeBalanceScreen> {
  String sharedCode = ""; // 서버에서 가져온 공유 코드를 저장하는 변수

  final db = FirebaseFirestore.instance;

  // 서버에서 공유 코드를 가져오는 함수 (실제 로직으로 교체 필요)
  Future<void> fetchSharedCode() async {
    // 실제 서버 API 엔드포인트 및 인증 정보를 설정하세요.
    const String apiUrl = "";

    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        // 서버로부터 공유 코드 가져오기 성공
        setState(() {
          sharedCode = response.body;
        });
      } else {
        // 서버로부터 공유 코드 가져오기 실패
        print(
            "Failed to fetch shared code. Status code: ${response.statusCode}");
      }
    } catch (error) {
      // 에러 처리
      print("Error fetching shared code: $error");
    }
  }

  // 공유 코드 알림창을 표시하는 함수
  void showShareCodeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Consumer<UserProviderR>(builder: (context, _, __) {
          return AlertDialog(
            title: const Text("발급받은 코드"),
            content: Text("당신의 가족 코드는:${_.familyCode}"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 알림창 닫기
                },
                child: const Text("확인"),
              ),
            ],
          );
        });
      },
    );
  }

  // 공유 코드 버튼 클릭을 처리하는 함수
  void onShareCodePressed() {
    // 서버에서 공유 코드를 가져오기
    fetchSharedCode();
    // 알림창으로 공유 코드 표시
    showShareCodeDialog();
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
      floatingActionButton: FloatingActionButton(
          //가족코드 공유 버튼
          onPressed: onShareCodePressed,
          child: const Text("가족코드 공유하기")),
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              Container(
                  padding: const EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    // 컨테이너의 background color
                    color: Colors.orangeAccent[100],

                    // 컨테이너의 border 모양
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Consumer<UserProviderR>(
                      builder: (context, userProvider, _) {
                    return Column(
                      children: [
                        Text(
                          "이름: ${userProvider.userName}",
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "직책: ${userProvider.userRole}",
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "점수: ${userProvider.userPoint}",
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    );
                  })),
              const SizedBox(
                height: 200,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed("balance_game");
                  },
                  child: const Text(
                    "밸런스 게임",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed("quiz");
                  },
                  child: const Text(
                    "퀴즈",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    context.goNamed("calender");
                  },
                  child: const Text(
                    "캘린더",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
