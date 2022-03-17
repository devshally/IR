import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

///The splash screen, which is the entry point of the application.
class SplashScreen extends StatelessWidget {
  ///The constructor does not take any parameters.
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      context.go('/login');
    });
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 130,
          child: Image.asset('assets/images/irlogo.png'),
        ),
      ),
    );
  }
}
