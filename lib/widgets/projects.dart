import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bowfolios/widgets/project_card.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("projects").snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          if (snapshot.data == null) return Text("There is no data");
          return ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (ctx, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              var data = ds.data();
              return ProjectCard(
                data["name"],
                data["description"],
                data["picture"],
                ds.id,
              );
            },
          );
        }
        return Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          child: Text("Loading Projects..."),
        );
      },
    );
  }
}
