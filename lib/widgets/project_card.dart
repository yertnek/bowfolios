import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String desc;
  final String id;
  final String imageURL;

  ProjectCard(this.title, this.desc, this.imageURL, this.id);

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  final firestoreInstance = FirebaseFirestore.instance;
  Widget _interestWidget = CircularProgressIndicator();
  Widget _profileWidget = CircularProgressIndicator();

  void _getWidgets() async {
    List<Widget> list = new List<Widget>();
    List<Widget> proflist = new List<Widget>();
    List<String> userIDs = new List<String>();

    await firestoreInstance
        .collection("projectsinterests")
        .where("project", isEqualTo: widget.id)
        .get()
        .then((value) {
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
        .where("project", isEqualTo: widget.id)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        userIDs.add(element.data()["profile"]);
      });
    });

    if (userIDs.length != 0) {
      for (var i = 0; i < userIDs.length; i++) {
        await firestoreInstance
            .collection("users")
            .doc(userIDs[i])
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

    setState(() {
      _profileWidget = Wrap(
        direction: Axis.horizontal,
        spacing: 3,
        runSpacing: -10,
        children: proflist,
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
            child: _profileWidget,
          ),
        ],
      ),
    );
  }
}
