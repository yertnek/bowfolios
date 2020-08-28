import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/main_drawer.dart';
import 'package:bowfolios/screens/profiles_screen.dart';
import 'package:bowfolios/screens/loading_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _pages = [
    ProfilesScreen(),
    ProfilesScreen(),
    ProfilesScreen(),
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
      appBar: AppBar(
        title: Text('BowFolios'),
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
