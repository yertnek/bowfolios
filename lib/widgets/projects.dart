import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/project_card.dart';

class Projects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: <Widget>[
        ProjectCard(
          'Open Power Quality',
          'Open source hardware and software for distributed power quality data collection, analysis, and visualization.',
          ['Software Development', 'Web Development'],
        ),
        ProjectCard(
          'RadGrad',
          'Growing awesome computer scientists, one graduate at a time.',
          ['Software Development', 'Web Development'],
        ),
      ],
    );
  }
}
