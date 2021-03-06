import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../screens/auth_screen.dart';
import '../screens/profile_screen.dart';
import 'package:bowfolios/screens/home_screen.dart';
import 'package:bowfolios/screens/add_project_screen.dart';
import 'package:bowfolios/screens/search_screen.dart';
import 'package:bowfolios/screens/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MainDrawer());
}

class MainDrawer extends StatefulWidget {
  final String username;

  const MainDrawer({Key key, this.username}) : super(key: key);
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;

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
      onTap: () {
        tapHandler();
      },
    );
  }

  void login(BuildContext ctx) {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return AuthScreen();
        },
      ),
    );
  }

  void logout(BuildContext ctx) {
    FirebaseAuth.instance.signOut();
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return HomeScreen();
        },
      ),
    );
  }

  void newPage(BuildContext ctx, Widget page) {
    Navigator.of(ctx).pushReplacement(
      MaterialPageRoute(
        builder: (_) {
          return page;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
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
                widget.username,
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ),
            buildListTile('Home', Icons.home, () {
              newPage(context, HomeScreen());
            }),
            buildListTile('Profile', Icons.person, () {
              newPage(context, ProfileScreen());
            }),
            buildListTile('Add Project', Icons.add, () {
              newPage(context, AddProjectScreen());
            }),
            buildListTile('Search', Icons.search, () {
              newPage(context, SearchScreen());
            }),
            buildListTile('Logout', Icons.exit_to_app, () {
              logout(context);
            }),
          ],
        ),
      );
    } else {
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
            buildListTile('Login', Icons.exit_to_app, () {
              login(context);
            }),
          ],
        ),
      );
    }
  }
}
