// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_report/app/core/splashscreen.dart';
import 'package:incident_report/app/features/authentication/presentation/pages/login.dart';

void main() {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) =>
            const LoginScreen(),
      ),
    ],
  );

  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      title: 'Incident Report',
      theme: ThemeData(
        primaryColor: const Color(0xFF6F448C),
      ),
    ),
  );
}
