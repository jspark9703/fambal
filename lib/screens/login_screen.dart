import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackton_project/provider/firebase_auth.dart';
import 'package:hackton_project/widgets/common/app_bar_auth.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: Consumer<ApplicationState>(builder: (context, appState, _) {
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Center(child:
              Consumer<ApplicationState>(builder: (context, appState, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 300,
                  width: 300,
                ),
                const SizedBox(height: 30),
                !appState.loggedIn
                    ? GestureDetector(
                        onTap: () {
                          context.go("/sign-in");
                        },
                        child: Image.asset(
                          "assets/images/google_login.png",
                          width: 200,
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          context.go("/user_info");
                        },
                        child: const Text('내 정보 입력'))
              ],
            );
          })),
        );
      }),
    );
  }
}
