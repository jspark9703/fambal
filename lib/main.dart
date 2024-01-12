import 'package:flutter/material.dart';
import 'package:hackton_project/provider/firebase_auth.dart';
import 'package:hackton_project/provider/user_info.dart';
import 'package:provider/provider.dart';

import './router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ApplicationState>(
          create: (_) => ApplicationState()),
      ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
