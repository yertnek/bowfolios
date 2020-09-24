import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/main_drawer.dart';
import 'package:bowfolios/widgets/project_form.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Add Project'),
      ),
      drawer: MainDrawer(),
      body: ProjectForm(),
    );
  }
}
