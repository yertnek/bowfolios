import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Username extends StatelessWidget {
  Username(this.userid);
  final String userid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection('users').doc(userid).get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            !snapshot.hasData) {
          return Text(
            'Username loading...',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 30,
            ),
          );
        }
        final DocumentSnapshot ds = snapshot.data;
        final userData = ds.data();
        return Text(
          userData["username"],
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),
        );
      },
    );
  }
}
