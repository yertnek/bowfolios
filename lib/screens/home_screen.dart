import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/main_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BowFolios'),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: Text('Need to figure out what to display on homescreen'),
      ),
    );
  }
}
