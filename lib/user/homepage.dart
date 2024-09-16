import 'package:flutter/material.dart';
import 'package:moukalaf/main.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  static const List<Widget> _children = [
    // const ClientDetail(),
    // const Income(),
    // const FamillyMember(),
    // const getAllNews(),
    // const UpdateInfos(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: x, // Set your primary color here
        unselectedItemColor: Colors.grey, // Set the unselected item color here
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Tasri7',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.family_restroom),
            label: 'Familly',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Last News',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Edit Profile',
          ),
        ],
      ),
    );
  }
}
