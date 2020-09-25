import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bowfolios/widgets/interest_card.dart';

class Interests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("interests").snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          return GridView.builder(
            padding: const EdgeInsets.all(25),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (ctx, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              var data = ds.data();
              return InterestCard(data["interest"]);
            },
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1.5,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
