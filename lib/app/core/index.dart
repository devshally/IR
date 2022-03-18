// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:incident_report/app/features/incident/presentation/pages/home.dart';
import 'package:incident_report/app/features/incident/presentation/pages/report.dart';
import 'package:incident_report/app/features/profile/presentation/pages/profile.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);
  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _pages.elementAt(currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        iconSize: 20,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: const Color(0xFF281850),
        unselectedItemColor: const Color(0xFFC4C4C4),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/home_bottom_nav_bar_icon.png'),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                'assets/images/transaction_details_bottom_nav_icon.png',
              ),
            ),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/images/profile_bottom_nav_icon.png'),
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex, //New
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  static final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    ReportScreen(),
    const ProfileScreen(),
  ];
}
