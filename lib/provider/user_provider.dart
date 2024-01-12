import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  User _user;

  UserProvider(this._user);

  User get user => _user;

  set user(User newUser) {
    _user = newUser;
    notifyListeners();
  }

  // 기타 사용자 정보를 업데이트하는 메서드 등을 추가할 수 있습니다.
  // 예를 들면, 사용자 포인트 업데이트 메서드 등.

  // 예시 메서드
}
