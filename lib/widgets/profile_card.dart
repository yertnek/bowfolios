import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final String title;
  final String desc;
  final List<String> interests;

  ProfileCard(this.name, this.title, this.desc, this.interests);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          ListTile(
            trailing: FlutterLogo(size: 72.0),
            title: Text(name),
            subtitle: Text(title),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Text(desc),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            height: 0,
            color: Colors.black,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.start,
            children: [
              for (var interest in interests)
                Chip(
                  label: Text(
                    interest,
                    style: TextStyle(color: Colors.white),
                  ),
                  backgroundColor: Colors.teal,
                ),
            ],
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            height: 0,
            color: Colors.black,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            alignment: Alignment.topLeft,
            child: Text('Projects'),
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
