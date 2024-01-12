import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String _name = ''; //이름
  String _birth = ''; //생년월일
  String _nickname = ''; //닉네임
  String _fam_nickname = ''; //애칭

  String get name => name;
  String get birth => _birth;
  String get nickname => _nickname;
  String get fam_nickname => _fam_nickname;

  set name(String inputName) {
    _name = inputName;
    notifyListeners();
  }

  set birth(String inputBirth) {
    _birth = inputBirth;
    notifyListeners();
  }

  set nickname(String inputNickname) {
    _nickname = inputNickname;
    notifyListeners();
  }

  set fam_nickname(String inputFamNickname) {
    _fam_nickname = inputFamNickname;
    notifyListeners();
  }
}
