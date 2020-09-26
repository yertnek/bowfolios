import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatefulWidget {
  final String title;
  final String desc;
  final Widget widget;

  ProjectCard(this.title, this.desc, this.widget);

  @override
  _ProjectCardState createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: FlutterLogo(size: 72.0),
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
          widget,
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
