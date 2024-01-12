import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackton_project/provider/firebase_auth.dart';
import 'package:hackton_project/provider/user_provider.dart';
import 'package:hackton_project/widgets/common/app_bar_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _niknameController =
      TextEditingController(); //닉네임
  final TextEditingController _userNameController =
      TextEditingController(); //유저
  final TextEditingController _famNicknameController =
      TextEditingController(); //애칭
  DateTime? _selectedDate;

  void sendUserServer() async {
    try {
      final userProvider = Provider.of<UserProviderApp>(context, listen: false);

      final response = await http.post(
        Uri.parse(''), //서버주소
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          // 'name': userProvider.user.birth,
          // 'birth': userProvider,
          // 'nickname': userProvider.nickname,
          // 'fam_nickname': userProvider.fam_nickname,
        }),
      );

      if (response.statusCode == 200) {
        // 성공적으로 서버에 전송됨
        print('Success: ${response.body}');
        // 여기서 사용자에게 회원가입이 성공했다는 메시지를 보여줄 수 있습니다.
      } else {
        // 서버 응답 실패
        print('Failed with status code: ${response.statusCode}');
        // 여기서 사용자에게 회원가입 실패 메시지를 보여줄 수 있습니다.
      }
    } catch (error) {
      // 예외 발생 시 처리
      print('Error: $error');
      // 여기서 사용자에게 오류 메시지를 보여줄 수 있습니다.
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProviderApp>(context, listen: false);

    return Scaffold(
      appBar: AppBar(actions: [
        Consumer<ApplicationState>(
          builder: (context, appState, _) => AuthFunc(
              loggedIn: appState.loggedIn,
              signOut: () {
                FirebaseAuth.instance.signOut();
              }),
        ),
      ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "정보를 입력해주세요!",
                        style: TextStyle(
                          fontSize: 36,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("가족코드"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      alignment: Alignment.center,
                      child: TextFormField(
                        controller: _niknameController,
                        decoration: InputDecoration(
                          hintText: "가족코드가 없다면 빈값으로 남겨주세요",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("이름"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      child: TextFormField(
                        controller: _userNameController,
                        decoration: InputDecoration(
                          hintText: "이름",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "이름을 입력해주세요";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        ).then((selectedDate) {
                          setState(() {
                            _selectedDate = selectedDate;
                            // 선택된 날짜를 UserProvider에 저장
                            if (_selectedDate != null) {
                              final birthDate =
                                  "${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}";
                              userProvider.user.birth = birthDate;
                            }
                          });
                        });
                      },
                      child: const Text("생년월일"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: const Text("가족 애칭"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Container(
                      child: TextFormField(
                        controller: _famNicknameController,
                        decoration: InputDecoration(
                          hintText: "가족 애칭",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "가족 애칭을 입력해주세요";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          userProvider.user.nickname = _niknameController.text;
                          userProvider.user.name = _userNameController.text;
                          userProvider.user.famNickname =
                              _famNicknameController.text;

                          sendUserServer();
                          GoRouter.of(context).goNamed("home"); // 라우터로 페이지 이동
                        }
                      },
                      child: const Text(
                        "완료",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
