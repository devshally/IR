// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildAvatar(),
        _buildTable(),
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

  Widget _buildTable() {
    return Table(
      children: const [
        TableRow(
          children: [
            Text('Name'),
            Text('Shalom Hedima'),
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
            Text('Devshally'),
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
            Text('Schedima1@gmail.com'),
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
            Text('09090404722'),
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
    );
  }
}
