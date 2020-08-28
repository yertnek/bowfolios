import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String title;
  final String desc;

  ProfileCard(this.name, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text(name),
            subtitle: Text(title),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(desc),
          ),
        ],
      ),
    );
  }
}
