// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_report/app/features/authentication/presentation/cubit/authentication_cubit.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  final String email = '';
  bool visible = false;

  void _showButton() {
    Timer(const Duration(seconds: 10), () {
      setState(() {
        visible = true;
      });
    });
  }

  @override
  void dispose() {
    _showButton();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _showButton();
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is EmailVerified) {
            context.go('/');
          }
        },
        builder: (context, state) {
          return _buildBody();
        },
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/paperplane.png',
              height: 150,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: Text(
                'Verify your email',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              "We've just sent you an email to $email",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const Text(
              'Kindly check to verify.',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 20),
            Visibility(
              visible: visible,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                ),
                child: const Text('Done'),
                onPressed: () {
                  BlocProvider.of<AuthenticationCubit>(context).verifyEmail();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
