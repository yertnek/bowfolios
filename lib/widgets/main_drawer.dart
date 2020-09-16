import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'BowFolios',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile('Home', Icons.home, () {}),
          buildListTile('Profile', Icons.person, () {}),
          buildListTile('Add Project', Icons.add, () {}),
          buildListTile('Search', Icons.search, () {}),
          ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 26,
              ),
              title: Text(
                'Logout',
                style: TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
              })
        ],
      ),
    );
  }
}
