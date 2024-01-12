import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hackton_project/provider/firebase_auth.dart';
import 'package:hackton_project/widgets/common/app_bar_auth.dart';
import 'package:provider/provider.dart';

class CommonAppbar extends StatelessWidget {
  const CommonAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(title: const Text("Fambal"), actions: [
      Consumer<ApplicationState>(
        builder: (context, appState, _) => AuthFunc(
            loggedIn: appState.loggedIn,
            signOut: () {
              FirebaseAuth.instance.signOut();
            }),
      ),
    ]);
  }
}
