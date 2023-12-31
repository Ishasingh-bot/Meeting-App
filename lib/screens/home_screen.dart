import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/history_meeting_screen.dart';
import 'package:zoom_clone/screens/meeting_screen.dart';
import 'package:zoom_clone/utils/colors.dart';
import 'package:zoom_clone/widgets/home_meeting_button.dart';

import '../resources/auth_methods.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthMethods _authMethods = AuthMethods();
  int _page = 0;
  onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  List<Widget> pages = [
    MeetingScreen(),
    const HistoryMeetingScreen(),
    Text('Contacts'),
    CustomButton(text: 'Log Out', onPressed: () => AuthMethods().signOut()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        title: const Text('Meet & Chat'),
        centerTitle: true,
      ),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: footerColor,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          onTap: onPageChanged,
          currentIndex: _page,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.comment_bank), label: 'Meet&Chat'),
            BottomNavigationBarItem(
                icon: Icon(Icons.lock_clock), label: 'Meeting'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: 'Contacts'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: 'Settings'),
          ]),
    );
  }
}
