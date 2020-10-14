import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bowfolios/widgets/main_drawer.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final firestoreInstance = FirebaseFirestore.instance;

  String username;

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
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Search'),
      ),
      drawer: MainDrawer(
        username: username,
      ),
      body: Text("Hello"),
    );
  }
}
