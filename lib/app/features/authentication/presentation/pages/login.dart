// ignore_for_file: sort_constructors_first, public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_report/app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:incident_report/app/features/authentication/presentation/widgets/textfield_widget.dart';

///
class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationLoaded) {
            context.go('/index');
          } else if (state is Error) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const Center(child: CircularProgressIndicator());
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
              'LOG-IN',
              style: TextStyle(fontSize: 24, color: Colors.blue.shade400),
            ),
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
          const SizedBox(height: 20),
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
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 100),
            ),
            onPressed: () {
              if (formGlobalKey.currentState!.validate()) {
                formGlobalKey.currentState!.save();
                BlocProvider.of<AuthenticationCubit>(context)
                    .login(emailController.text, passwordController.text);
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () => context.go('/signup'),
            child: const Text(
              "Dont't have an account? Sign Up",
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
