import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hackton_project/provider/user_provider.dart';
import 'package:hackton_project/screens/balance_game_screen.dart';
import 'package:hackton_project/screens/home_balance_screen.dart';
import 'package:hackton_project/screens/imformation_screen.dart';
import 'package:hackton_project/screens/login_screen.dart';
import 'package:hackton_project/screens/quiz_screen.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  routes: [
    GoRoute(
        path: '/home_balance',
        name: "home",
        builder: (context, state) => const HomeBalanceScreen(),
        routes: [
          GoRoute(
            path: 'quiz',
            name: "quiz",
            builder: (context, state) => const QuizScreen(),
          ),
          GoRoute(
            path: 'result',
            name: "result",
            builder: (context, state) => const QuizScreen(),
          ),
          GoRoute(
            path: 'balance_game',
            name: "balance_game",
            builder: (context, state) => const BalanceScreen(),
          ),
        ]),
    GoRoute(
      path: '/',
      builder: (context, state) =>
          Consumer<UserProviderApp>(builder: (context, user, _) {
        return const LoginScreen();
      }),
      routes: [
        GoRoute(
          path: "user_info",
          builder: (context, state) => const InformationScreen(),
        ),
        GoRoute(
          path: 'sign-in',
          builder: (context, state) {
            return SignInScreen(
              actions: [
                ForgotPasswordAction(((context, email) {
                  final uri = Uri(
                    path: '/sign-in/forgot-password',
                    queryParameters: <String, String?>{
                      'email': email,
                    },
                  );
                  context.push(uri.toString());
                })),
                AuthStateChangeAction(((context, state) {
                  final user = switch (state) {
                    SignedIn state => state.user,
                    UserCreated state => state.credential.user,
                    _ => null
                  };
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  context.pushReplacement('/');
                })),
              ],
            );
          },
          routes: [
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) {
                final arguments = state.pathParameters;
                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) {
            // final imgUrl = state.extra as String;
            return ProfileScreen(
              appBar: AppBar(title: const Text("Profile")),
              avatarSize: 150,
              providers: const [],
              actions: [
                SignedOutAction((context) {
                  context.pushReplacement('/');
                }),
              ],
            );
          },
        ),
      ],
    ),
  ],
);
