import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class BalnceScreen extends StatefulWidget {
  const BalnceScreen({super.key});

  @override
  _BalnceScreenState createState() => _BalnceScreenState();
}

class _BalnceScreenState extends State<BalnceScreen> {
  String selectedButton = ''; // 선택된 버튼
  String question = ''; // 서버에서 받아온 질문
  List<String> balanceGames = []; // 서버에서 받아온 밸런스 게임 목록

  @override
  void initState() {
    super.initState();
    // initState에서 서버에서 데이터를 가져오는 함수 호출
    fetchDataFromServer();
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
  Future<void> sendSelectedButtonToServer() async {
    try {
      // 실제 서버의 URL로 수정
      final response = await http.post(
        Uri.parse(''),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'selectedButton': selectedButton,
        }),
      );

      if (response.statusCode == 200) {
        // 서버에 성공적으로 전송한 경우
        print('Selected button sent to server successfully.');
      } else {
        // 서버에 전송하지 못한 경우
        print(
            'Failed to send selected button to server. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // 오류 발생 시
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("밸런스 게임"),
        actions: const <Widget>[],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: Text(
                question.isNotEmpty ? question : '로딩 중...', // 서버에서 받아온 질문 표시
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 170),
            Container(
              alignment: Alignment.center,
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedButton = 'left'; // 왼쪽 버튼 선택
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selectedButton == 'left' ? Colors.green : null,
                ),
                child: Text(
                  balanceGames.isNotEmpty
                      ? balanceGames[0]
                      : '로딩 중...', // 서버에서 받아온 밸런스 게임 표시
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            Container(
              child: const Text(
                "Vs",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedButton = 'right'; // 오른쪽 버튼 선택
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      selectedButton == 'right' ? Colors.blue : null,
                ),
                child: Text(
                  balanceGames.length > 1
                      ? balanceGames[1]
                      : '로딩 중...', // 서버에서 받아온 밸런스 게임 표시
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () {
                  // 선택된 버튼에 따라 다른 동작 수행
                  if (selectedButton == 'left') {
                    // 왼쪽 버튼 선택 시 동작
                  } else if (selectedButton == 'right') {
                    // 오른쪽 버튼 선택 시 동작
                  }

                  // 선택된 버튼을 서버에 전송
                  sendSelectedButtonToServer();

                  GoRouter.of(context).go("/home"); // 라우터로 페이지 이동
                },
                child: const Text("완료", style: TextStyle(color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
