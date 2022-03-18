// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_report/app/features/authentication/presentation/cubit/authentication_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthenticationCubit>(context).getUserProfile();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                BlocProvider.of<AuthenticationCubit>(context).logout(),
            icon: const Icon(
              Icons.logout_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Column(
          children: [
            Image.asset('assets/images/irlogo.png', height: 60),
            Text(
              'PROFILE',
              style: TextStyle(color: Colors.blue.shade400, letterSpacing: 1),
            ),
          ],
        ),
        toolbarHeight: 100,
      ),
      body: BlocConsumer<AuthenticationCubit, AuthenticationState>(
        listener: (context, state) {
          if (state is AuthenticationInitial) {
            context.go('/login');
          }
        },
        builder: (context, state) {
          if (state is AuthenticationLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is UserProfile) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: _buildBody(
                state.user.fullName.toString(),
                state.user.username.toString(),
                state.user.email.toString(),
                state.user.phone.toString(),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildBody(
      String name, String username, String email, String phoneNumber) {
    return Column(
      children: [
        _buildAvatar(),
        _buildTable(name, username, email, phoneNumber),
      ],
    );
  }

  Widget _buildAvatar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Container(
        height: 106,
        width: 106,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1.5, color: Colors.blue.shade400),
          image: const DecorationImage(
            image: AssetImage('assets/images/paperplane.png'),
            // fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildTable(
      String name, String username, String email, String phoneNumber) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Table(
        children: [
          TableRow(
            children: [
              Text('Name'),
              Text(name),
            ],
          ),
          TableRow(
            children: [
              SizedBox(height: 15),
              SizedBox(height: 15),
            ],
          ),
          TableRow(
            children: [
              Text('Username'),
              Text(username),
            ],
          ),
          TableRow(
            children: [
              SizedBox(height: 15),
              SizedBox(height: 15),
            ],
          ),
          TableRow(
            children: [
              Text('Email'),
              Text(email),
            ],
          ),
          TableRow(
            children: [
              SizedBox(height: 15),
              SizedBox(height: 15),
            ],
          ),
          TableRow(
            children: [
              Text('Phone Number'),
              Text(phoneNumber),
            ],
          ),
          TableRow(
            children: [
              SizedBox(height: 15),
              SizedBox(height: 15),
            ],
          ),
          TableRow(
            children: [
              Text('Location'),
              Text('Lekki, Lagos.'),
            ],
          ),
        ],
      ),
    );
  }
}
