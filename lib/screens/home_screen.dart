import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/main_drawer.dart';
import 'package:bowfolios/screens/profiles_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BowFolios'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: ProfilesScreen(),
      ),
    );
  }
}
