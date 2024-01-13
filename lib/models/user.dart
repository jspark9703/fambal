import 'package:flutter/material.dart';

import 'random_str.dart'; // 알맞은 파일 경로로 수정

class UserProviderR extends ChangeNotifier {
  String uid;
  int state;
  int userPoint;
  String userRole;
  String userNickname;
  String userName;
  String userBirth;
  int? familyNum;
  String? familyCode;

  UserProviderR({
    required this.uid,
    required this.state,
    required this.userPoint,
    required this.userRole,
    required this.userNickname,
    required this.userName,
    required this.userBirth,
    this.familyNum,
    this.familyCode,
  }) {
    if (familyCode == null || familyCode == "") {
      familyCode = generateRandomString(6);
      notifyListeners();
    }
  }

  set setPoint(int input) {
    userPoint = input;
    notifyListeners();
  }

  set setName(String inputName) {
    userName = inputName;
    notifyListeners();
  }

  set role(String input) {
    userRole = input;
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

  set setFamilyNum(int input) {
    familyNum = input;
    notifyListeners();
  }

  set setState(int input) {
    state = input;
    notifyListeners();
  }

  factory UserProviderR.fromJson(Map<String, dynamic> json) {
    return UserProviderR(
      uid: json['uid'],
      state: json['state'],
      userPoint: json['user_point'],
      userRole: json['user_role'],
      userNickname: json['user_nickname'],
      userName: json['user_name'],
      userBirth: json['user_birth'],
      familyNum: json['family_num'],
      familyCode: json['family_code'],
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
      'family_num': familyNum,
      'family_code': familyCode,
    };
  }
}
