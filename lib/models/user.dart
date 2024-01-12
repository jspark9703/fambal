import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String uid;
  int state;
  int userPoint;
  String userRole;
  String userNickname;
  String userName;
  String userBirth;
  String? famUserName;

  User({
    required this.uid,
    required this.state,
    required this.userPoint,
    required this.userRole,
    required this.userNickname,
    required this.userName,
    required this.userBirth,
    required this.famUserName,
  });

  set name(String inputName) {
    userName = inputName;
    notifyListeners();
  }

  set birth(String inputBirth) {
    userBirth = inputBirth;
    notifyListeners();
  }

  set nickname(String inputNickname) {
    userNickname = inputNickname;
    notifyListeners();
  }

  set famNickname(String inputFamNickname) {
    famUserName = inputFamNickname;
    notifyListeners();
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      state: json['state'],
      userPoint: json['user_point'],
      userRole: json['user_role'],
      userNickname: json['user_nickname'],
      userName: json['user_name'],
      userBirth: json['user_birth'],
      famUserName: json['fam_user_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'state': state,
      'user_point': userPoint,
      'user_role': userRole,
      'user_nickname': userNickname,
      'user_name': userName,
      'user_birth': userBirth,
      'fam_user_name': famUserName,
    };
  }
}

//사용법
// // 예시 사용자 정보 생성
// User user = User(
//   uid: "user_code_123",
//   state: 1,
//   userPoint: 100,
//   userRole: "Player",
//   userNickname: "Player1",
//   userName: "John Doe",
//   userBirth: "1990-01-01",
//   famUserName: "FamilyUser1",
// );

// // 사용자 정보를 JSON으로 변환
// Map<String, dynamic> userJson = user.toJson();

// // JSON을 사용자 객체로 변환
// User userFromJson = User.fromJson(userJson);