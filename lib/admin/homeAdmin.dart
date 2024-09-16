import 'package:flutter/material.dart';
import 'package:moukalaf/admin/calculator.dart';
import 'package:moukalaf/admin/clientRequests.dart';
import 'package:moukalaf/admin/getWorksRate.dart';
import 'package:moukalaf/admin/getclients.dart';

import 'package:moukalaf/main.dart';
import 'package:moukalaf/user/getNews.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeAdmin> {
  int _currentIndex = 0;
  static const List<Widget> _children = [
    getClients(),
    AdminCalculators(),
    Calculator(),
    getAllNews(),
    GetWorksRate()
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
        selectedItemColor: x, // Set the color of the selected item
        unselectedItemColor: Colors.grey, // Set the color of the unselected
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.request_page),
            label: ' Requests',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Calculator',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Last News',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: 'Work Rate',
          ),
        ],
      ),
    );
  }
}
