import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bowfolios/widgets/project_card.dart';

class Projects extends StatefulWidget {
  @override
  _ProjectsState createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final firestoreInstance = FirebaseFirestore.instance;
  List<String> _interests = [];

  Future<void> _getInterests(String projID) async {
    await firestoreInstance
        .collection("projectsinterests")
        .where("project", isEqualTo: projID)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        _interests.add(element.data()["interest"]);
      });
    });
  }

  Widget _interestsWidget(List<String> ints) {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < ints.length; i++) {
      list.add(
        new Chip(
          label: Text(ints[i]),
        ),
      );
    }
    return new Wrap(
        direction: Axis.horizontal,
        spacing: 3,
        runSpacing: -10,
        children: list);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("projects").snapshots(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState != ConnectionState.waiting) {
          return ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (ctx, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              var data = ds.data();
              _getInterests(ds.id);
              Widget test = _interestsWidget(_interests);
              _interests = [];
              return ProjectCard(
                data["name"],
                data["description"],
                test,
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
