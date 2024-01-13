import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackton_project/models/user.dart';
import 'package:hackton_project/provider/firebase_auth.dart';
import 'package:hackton_project/widgets/common/app_bar_auth.dart';
import 'package:provider/provider.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({Key? key}) : super(key: key);

  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _niknameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userRollController = TextEditingController();
  DateTime? _selectedDate;
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 243, 221, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(252, 243, 221, 1),
        actions: [
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Center(
            child: Container(
              width: 342,
              height: 600,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            width: 340,
                            height: 50,
                            decoration: BoxDecoration(
                              // 컨테이너의 background color
                              color: Colors.orangeAccent[100],
                              // 컨테이너의 border 모양
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            child: const Text("정보를 입력해주세요!",
                                style: TextStyle(fontSize: 26)),
                          ),
                        ],
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
                      Consumer<UserProviderR>(
                          builder: (context, userProvider, _) {
                        return Padding(
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
                                    userProvider.birth = birthDate;
                                  }
                                });
                              });
                            },
                            child: const Text(
                              "생년월일",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: const Text("직책"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          child: TextFormField(
                            controller: _userRollController,
                            decoration: InputDecoration(
                              hintText: "직책",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "직책을 입력해주세요";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<UserProviderR>(builder: (context, userProvider, _) {
            return ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  userProvider.familyCode = _niknameController.text;
                  userProvider.setName = _userNameController.text;
                  userProvider.role = _userRollController.text;
                  try {
                    db.collection("user").doc().set(userProvider.toJson());
                  } catch (e) {
                    print(e);
                  }
                  GoRouter.of(context).goNamed("home"); // 라우터로 페이지 이동
                }
              },
              child: const Text(
                "완료",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
