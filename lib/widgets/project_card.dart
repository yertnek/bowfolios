import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String desc;
  final Widget interestsWidget;

  ProjectCard(this.title, this.desc, this.interestsWidget);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text(title),
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 10,
            ),
            child: Text(desc),
          ),
          Divider(
            indent: 10,
            endIndent: 10,
            height: 0,
            color: Colors.black,
          ),
          interestsWidget,
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
