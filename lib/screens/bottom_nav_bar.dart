import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/aichat/ai_chat_page.dart';
import 'package:flutter_application_1/screens/handcontrol/hand_control_page.dart';
import 'package:flutter_application_1/screens/home/home_page.dart';
import 'package:flutter_application_1/screens/progress/progress_page.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    ProgressPage(),
    ChatPage(),
    HandControlPage()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'AI Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.back_hand_rounded),
            label: 'Hand control',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff1F59DA),
        unselectedItemColor: Color(0xff676D75),
        onTap: _onItemTapped,
        selectedLabelStyle: GoogleFonts.poppins(
            color: Color(0xff1F59DA),
            fontWeight: FontWeight.w500,
            fontSize: 11),
        unselectedLabelStyle: GoogleFonts.poppins(
            color: Color(0xff676D75),
            fontWeight: FontWeight.w500,
            fontSize: 11),
      ),
    );
  }
}
