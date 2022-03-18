// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_report/app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:incident_report/app/features/authentication/presentation/widgets/textfield_widget.dart';

///
class SignUpScreen extends StatelessWidget {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoaded) {
            context.go('/emailVerification');
          } else if (state is Error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: _buildBody(context),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Form(
      key: formGlobalKey,
      child: Column(
        children: [
          Image.asset('assets/images/irlogo.png', height: 100),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'SIGN-UP',
              style: TextStyle(fontSize: 24, color: Colors.blue.shade400),
            ),
          ),
          TextFieldWidget(controller: fullNameController, label: 'Full Name'),
          TextFieldWidget(
            label: 'Username',
            controller: usernameController,
            validator: (username) {
              if (username!.length < 3) {
                return 'Enter a valid username';
              } else {
                return null;
              }
            },
          ),
          TextFieldWidget(
            keyboardType: TextInputType.emailAddress,
            label: 'E-mail',
            controller: emailController,
            validator: (email) {
              const pattern =
                  r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              final regex = RegExp(
                pattern,
              );
              if (!regex.hasMatch(email!)) {
                return 'Enter a valid email';
              } else {
                return null;
              }
            },
          ),
          TextFieldWidget(
            keyboardType: TextInputType.phone,
            label: 'Phone Number',
            controller: phoneController,
            validator: (phone) {
              if (phone!.length < 11) {
                return 'Enter a valid phone number';
              } else {
                return null;
              }
            },
          ),
          TextFieldWidget(
            label: 'Password',
            obscured: true,
            controller: passwordController,
            validator: (password) {
              if (password!.length < 6) {
                return 'Enter a valid password';
              } else {
                return null;
              }
            },
          ),
          TextFieldWidget(
            label: 'Confirm Password',
            obscured: true,
            controller: confirmPasswordController,
            validator: (password) {
              if (password!.length < 6) {
                return 'Enter a valid password';
              } else if (password != passwordController.text) {
                return 'Passwords do not match';
              } else {
                return null;
              }
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
            ),
            onPressed: () {
              if (formGlobalKey.currentState!.validate()) {
                formGlobalKey.currentState!.save();
                BlocProvider.of<AuthenticationCubit>(context).signup(
                  emailController.text,
                  passwordController.text,
                  usernameController.text,
                  phoneController.text,
                  fullNameController.text,
                );
              }
            },
            child: const Text('Sign Up'),
          ),
          TextButton(
            onPressed: () => context.go('/login'),
            child: const Text(
              'Already have an account? Login',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
