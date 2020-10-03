import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bowfolios/screens/interests_screen.dart';

class InterestCard extends StatelessWidget {
  final String interest;
  final firestoreInstance = FirebaseFirestore.instance;
  InterestCard(this.interest);

  void selectInterest(BuildContext ctx) async {
    List<String> userIDs = new List<String>();
    await firestoreInstance
        .collection("profilesinterest")
        .where("interest", isEqualTo: interest)
        .get()
        .then((value) {
      if (value.docs.length != 0) {
        value.docs.forEach((element) async {
          userIDs.add(element.data()["profile"]);
        });
      }
    });
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return InterestsScreen(interest, userIDs);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectInterest(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Text(
          interest,
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.7),
              Colors.lightGreen,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
