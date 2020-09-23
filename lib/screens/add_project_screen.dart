import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/main_drawer.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Add Project'),
      ),
      drawer: MainDrawer(),
      body: Text("Hello"),
    );
  }
}
