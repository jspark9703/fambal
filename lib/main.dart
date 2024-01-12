import 'package:flutter/material.dart';
import 'package:hackton_project/models/user.dart';
import 'package:hackton_project/provider/firebase_auth.dart';
import 'package:hackton_project/provider/user_info.dart';
import 'package:hackton_project/provider/user_provider.dart';
import 'package:provider/provider.dart';

import './router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ApplicationState>(
          create: (_) => ApplicationState()),
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ChangeNotifierProvider<UserProviderApp>(
          create: (_) => UserProviderApp(User(
                uid: "default_uid",
                state: 0,
                userPoint: 0,
                userRole: "default_role",
                userNickname: "default_nickname",
                userName: "default_name",
                userBirth: "default_birth",
                famUserName: "default_fam_user_name",
              ))),
    ],
    builder: ((context, child) => const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 89, 243, 33)),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
