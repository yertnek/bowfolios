import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/main_drawer.dart';
import 'package:bowfolios/widgets/project_form.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
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
        title: Text('Add Project'),
      ),
      drawer: MainDrawer(
        username: username,
      ),
      body: ProjectForm(),
    );
  }
}
