import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryInfo extends StatefulWidget {
  final String interestName;
  final List<String> userIDs;

  CategoryInfo(this.interestName, this.userIDs);

  @override
  _CategoryInfoState createState() => _CategoryInfoState();
}

class _CategoryInfoState extends State<CategoryInfo> {
  final firestoreInstance = FirebaseFirestore.instance;
  Widget _profileWidget = Icon(Icons.inbox);

  void _getProfiles() async {
    List<Widget> list = new List<Widget>();
    if (widget.userIDs.length != 0) {
      for (var i = 0; i < widget.userIDs.length; i++) {
        await firestoreInstance
            .collection("users")
            .doc(widget.userIDs[i])
            .get()
            .then((value) {
          list.add(
            new CircleAvatar(
              backgroundImage: NetworkImage(value.data()["picture"]),
            ),
          );
        });
      }
    } else {
      list.add(
        new Text("No profiles associated with this interst"),
      );
    }
    setState(() {
      _profileWidget = Wrap(
          direction: Axis.horizontal,
          spacing: 3,
          runSpacing: -10,
          children: list);
    });
  }

  @override
  Widget build(BuildContext context) {
    _getProfiles();
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
      ],
    );
  }
}
