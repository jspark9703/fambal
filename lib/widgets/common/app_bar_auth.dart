import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthFunc extends StatelessWidget {
  const AuthFunc({
    super.key,
    required this.loggedIn,
    required this.signOut,
  });

  final bool loggedIn;
  final void Function() signOut;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24, bottom: 8),
          child: TextButton(
              onPressed: () {
                if (!loggedIn) {
                  context.push('/sign-in');
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("로그아웃 하시겠습니까?"),
                      actions: <Widget>[
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('아니요'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            textStyle: Theme.of(context).textTheme.labelLarge,
                          ),
                          child: const Text('예'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            signOut();
                            context.go("/");
                          },
                        ),
                      ],
                    ),
                  );
                }
              },
              child: !loggedIn ? const Text('sign-in') : const Text('Logout')),
        ),
        Visibility(
            visible: loggedIn,
            child: Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 8),
              child: TextButton(
                  onPressed: () {
                    context.push(
                      '/profile',
                    );
                  },
                  child: const Text('Profile')),
            )),
      ],
    );
  }
}
