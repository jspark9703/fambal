import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

import '../firebase_options.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }
  String? userEmail;
  String? uid;
  String? userAvatarUrl;
  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  bool _emailVerified = false;

  bool get emailVerified => _emailVerified;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      GoogleProvider(
          clientId:
              "881846059899-roh040a3scgo2v7o8j55tr6hlfgp4hkr.apps.googleusercontent.com"),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        FirebaseStorage.instance
            .refFromURL(
                "gs://gdsc-movie-app.appspot.com/user_img/${user.uid}/KakaoTalk_20231215_175441153.jpg")
            .getDownloadURL()
            .then((value) {
          userAvatarUrl = value;
        });
        uid = user.uid;
        userEmail = user.email;
        _loggedIn = true;
        _emailVerified = user.emailVerified;
      } else {
        _loggedIn = false;
        _emailVerified = false;
      }
      notifyListeners();
    });
  }
}
