// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:incident_report/app/features/authentication/presentation/cubit/authentication_cubit.dart';
import 'package:incident_report/app/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProfileCubit>(context).getUserProfile();
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocListener<AuthenticationCubit, AuthenticationState>(
            listener: (context, state) {
              if (state is AuthenticationInitial) {
                context.go('/login');
              }
            },
            child: IconButton(
              onPressed: () {
                BlocProvider.of<AuthenticationCubit>(context).logout();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.black,
                size: 30,
              ),
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
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileInitial) {
            ///Work on this
            context.go('/login');
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProfileLoaded) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: _buildBody(
                state.user.fullName.toString(),
                state.user.username.toString(),
                state.user.email.toString(),
                state.user.phone.toString(),
                state.user.userProfile.toString(),
                context,
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildBody(
    String name,
    String username,
    String email,
    String phoneNumber,
    String userProfile,
    BuildContext context,
  ) {
    return Column(
      children: [
        _buildAvatar(context, userProfile),
        _buildTable(name, username, email, phoneNumber),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context, String userProfile) {
    return GestureDetector(
      onTap: () =>
          BlocProvider.of<ProfileCubit>(context).updateProfilePicture(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Container(
          height: 120,
          width: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1.5, color: Colors.blue.shade400),
            image: DecorationImage(
              image: NetworkImage(userProfile),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTable(
    String name,
    String username,
    String email,
    String phoneNumber,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Table(
        children: [
          TableRow(
            children: [
              const Text('Name:'),
              Text(name),
            ],
          ),
          const TableRow(
            children: [
              SizedBox(height: 15),
              SizedBox(height: 15),
            ],
          ),
          TableRow(
            children: [
              const Text('Username:'),
              Text(username),
            ],
          ),
          const TableRow(
            children: [
              SizedBox(height: 15),
              SizedBox(height: 15),
            ],
          ),
          TableRow(
            children: [
              const Text('Email:'),
              Text(email),
            ],
          ),
          const TableRow(
            children: [
              SizedBox(height: 15),
              SizedBox(height: 15),
            ],
          ),
          TableRow(
            children: [
              const Text('Phone Number:'),
              Text(phoneNumber),
            ],
          ),
          // const TableRow(
          //   children: [
          //     SizedBox(height: 15),
          //     SizedBox(height: 15),
          //   ],
          // ),
          // const TableRow(
          //   children: [
          //     Text('Location'),
          //     Text('Lekki, Lagos.'),
          //   ],
          // ),
        ],
      ),
    );
  }
}
