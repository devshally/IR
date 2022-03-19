// ignore_for_file: omit_local_variable_types, avoid_void_async

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_report/app/core/index.dart';
import 'package:incident_report/app/core/splashscreen.dart';
import 'package:incident_report/app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:incident_report/app/features/authentication/presentation/pages/email_verification.dart';
import 'package:incident_report/app/features/authentication/presentation/pages/login.dart';
import 'package:incident_report/app/features/authentication/presentation/pages/signup.dart';
import 'package:incident_report/app/features/incident/presentation/cubit/incident_cubit.dart';
import 'package:incident_report/app/features/incident/presentation/pages/home.dart';
import 'package:incident_report/app/features/incident/presentation/pages/report.dart';
import 'package:incident_report/app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:incident_report/app/features/profile/presentation/pages/profile.dart';

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
      GoRoute(
        path: '/index',
        builder: (BuildContext context, GoRouterState state) => const Index(),
      ),
      GoRoute(
        path: '/home',
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),
      GoRoute(
        path: '/report',
        builder: (BuildContext context, GoRouterState state) =>
            const ReportScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (BuildContext context, GoRouterState state) =>
            const ProfileScreen(),
      ),
    ],
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationCubit>(
          create: (context) => AuthenticationCubit(),
        ),
        BlocProvider<IncidentCubit>(
          create: (context) => IncidentCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
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
