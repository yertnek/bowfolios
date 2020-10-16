import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final String title;
  final String desc;
  final String id;
  final String imageURL;

  ProfileCard(this.title, this.desc, this.imageURL, this.id);

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  final firestoreInstance = FirebaseFirestore.instance;
  Widget _interestWidget = CircularProgressIndicator();
  Widget _projectWidget = CircularProgressIndicator();

  void _getWidgets() async {
    List<Widget> list = new List<Widget>();
    List<Widget> projlist = new List<Widget>();
    List<String> projIDs = new List<String>();

    await firestoreInstance
        .collection("profilesinterest")
        .where("profile", isEqualTo: widget.id)
        .get()
        .then((value) {
      if (value.docs.length == 0) {
        list.add(new Text("No interests associated with this profile"));
      }
      value.docs.forEach((element) {
        list.add(
          new Chip(
            label: Text(
              element.data()["interest"],
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.teal,
          ),
        );
      });
      setState(() {
        _interestWidget = Wrap(
            direction: Axis.horizontal,
            spacing: 3,
            runSpacing: -10,
            children: list);
      });
    });

    await firestoreInstance
        .collection("profilesprojects")
        .where("profile", isEqualTo: widget.id)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        projIDs.add(element.data()["project"]);
      });
    });

    if (projIDs.length != 0) {
      for (var i = 0; i < projIDs.length; i++) {
        await firestoreInstance
            .collection("projects")
            .doc(projIDs[i])
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
        new Text("No projects associated with this profile"),
      );
    }

    setState(() {
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
    return Card(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(widget.imageURL),
            ),
            title: Text(widget.title),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: Text(widget.desc),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            height: 0,
            color: Colors.black,
          ),
          _interestWidget,
          Divider(
            indent: 10,
            endIndent: 10,
            height: 0,
            color: Colors.black,
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: _projectWidget,
          ),
        ],
      ),
    );
  }
}
