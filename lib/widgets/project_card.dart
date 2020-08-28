import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String desc;

  ProjectCard(this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text(title),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Text(desc),
          ),
        ],
      ),
    );
  }
}
