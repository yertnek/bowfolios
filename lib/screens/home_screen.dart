import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bowfolios/widgets/main_drawer.dart';
import 'package:bowfolios/widgets/profiles.dart';
import 'package:bowfolios/widgets/projects.dart';
import 'package:bowfolios/widgets/interests.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  String username;

  final List<Widget> _pages = [
    Profiles(),
    Projects(),
    Interests(),
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

  Future<void> _username() async {
    await firestoreInstance
        .collection("users")
        .doc(auth.currentUser.uid)
        .get()
        .then(
      (value) {
        setState(() {
          username = value.data()['username'];
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _username();
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(headers[_selectedPageIndex]),
      ),
      drawer: MainDrawer(username: username),
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
