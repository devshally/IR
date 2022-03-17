// ignore_for_file: omit_local_variable_types, avoid_void_async

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_report/app/core/splashscreen.dart';
import 'package:incident_report/app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:incident_report/app/features/authentication/presentation/pages/email_verification.dart';
import 'package:incident_report/app/features/authentication/presentation/pages/login.dart';
import 'package:incident_report/app/features/authentication/presentation/pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (BuildContext context, GoRouterState state) => LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (BuildContext context, GoRouterState state) => SignUpScreen(),
      ),
      GoRoute(
        path: '/emailVerification',
        builder: (BuildContext context, GoRouterState state) =>
            const EmailVerification(),
      ),
    ],
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'Incident Report',
        theme: ThemeData(
          primaryColor: const Color(0xFF6F448C),
        ),
      ),
    ),
  );
}
