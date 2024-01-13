import 'package:flutter/material.dart';
import 'package:hackton_project/models/user.dart';
import 'package:hackton_project/provider/firebase_auth.dart';
import 'package:provider/provider.dart';

import './router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ApplicationState>(
          create: (_) => ApplicationState()),
      ChangeNotifierProvider<UserProviderR>(
          create: (_) => UserProviderR(
                uid: 'user123',
                state: 0,
                userPoint: 000,
                userRole: 'user',
                userNickname: 'nickname123',
                userName: 'John Doe',
                userBirth: '1990-01-01',
                familyNum: 123,
                // familyCode is optional and will be generated if not provided
              )),
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
