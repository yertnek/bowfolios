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
          return ListView.builder(
            padding: EdgeInsets.all(15),
            itemCount: snapshot.data.documents.length,
            itemBuilder: (ctx, index) {
              DocumentSnapshot ds = snapshot.data.documents[index];
              var data = ds.data();
              List<Widget> list = new List<Widget>();
              Widget _interestWidget;
              firestoreInstance
                  .collection("projectsinterests")
                  .where("project", isEqualTo: ds.id)
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  list.add(
                    new Chip(
                      label: Text(element.data()["interest"]),
                    ),
                  );
                });
                _interestWidget = Wrap(
                    direction: Axis.horizontal,
                    spacing: 3,
                    runSpacing: -10,
                    children: list);
              });
              return ProjectCard(
                data["name"],
                data["description"],
                _interestWidget,
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
