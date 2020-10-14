import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryInfo extends StatefulWidget {
  final String interestName;
  final List<String> userIDs;
  final List<String> projIDs;

  CategoryInfo(this.interestName, this.userIDs, this.projIDs);

  @override
  _CategoryInfoState createState() => _CategoryInfoState();
}

class _CategoryInfoState extends State<CategoryInfo> {
  final firestoreInstance = FirebaseFirestore.instance;
  Widget _profileWidget = CircularProgressIndicator();
  Widget _projectWidget = CircularProgressIndicator();

  void _getWidgets() async {
    List<Widget> proflist = new List<Widget>();
    List<Widget> projlist = new List<Widget>();
    if (widget.userIDs.length != 0) {
      for (var i = 0; i < widget.userIDs.length; i++) {
        await firestoreInstance
            .collection("users")
            .doc(widget.userIDs[i])
            .get()
            .then((value) {
          String profImg = value.data()["picture"];
          proflist.add(
            new CircleAvatar(
              backgroundImage: NetworkImage(profImg),
            ),
          );
        });
      }
    } else {
      proflist.add(
        new Text("No profiles associated with this interst"),
      );
    }

    if (widget.projIDs.length != 0) {
      for (var i = 0; i < widget.projIDs.length; i++) {
        await firestoreInstance
            .collection("projects")
            .doc(widget.projIDs[i])
            .get()
            .then((value) {
          String projImg = value.data()["picture"];
          projlist.add(
            new CircleAvatar(
              backgroundImage: NetworkImage(projImg),
            ),
          );
        });
      }
    } else {
      projlist.add(
        new Text("No projects associated with this interst"),
      );
    }
    setState(() {
      _profileWidget = Wrap(
        direction: Axis.horizontal,
        spacing: 3,
        runSpacing: -10,
        children: proflist,
      );
      _projectWidget = Wrap(
        direction: Axis.horizontal,
        spacing: 3,
        runSpacing: -10,
        children: projlist,
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _getWidgets();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Profiles"),
        Divider(
          color: Colors.black,
          indent: 10,
          endIndent: 10,
        ),
        _profileWidget,
        Text("Projects"),
        Divider(
          color: Colors.black,
          indent: 10,
          endIndent: 10,
        ),
        _projectWidget,
      ],
    );
  }
}
