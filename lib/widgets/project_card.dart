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
  Widget _interestWidget = Icon(Icons.inbox);

  void _getInterests(String projID) async {
    List<Widget> list = new List<Widget>();
    await firestoreInstance
        .collection("projectsinterests")
        .where("project", isEqualTo: projID)
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
  }

  @override
  Widget build(BuildContext context) {
    _getInterests(widget.id);
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
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Image(
                  height: 50,
                  width: 50,
                  image: NetworkImage(
                      'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
