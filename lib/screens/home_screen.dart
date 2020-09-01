import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/main_drawer.dart';
import 'package:bowfolios/widgets/profiles.dart';
import 'package:bowfolios/widgets/projects.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    Profiles(),
    Projects(),
    Profiles(),
  ];

  final List headers = [
    'Profiles',
    'Projects',
    'Interests',
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(headers[_selectedPageIndex]),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Profiles'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            title: Text('Projects'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Interests'),
          ),
        ],
      ),
    );
  }
}
