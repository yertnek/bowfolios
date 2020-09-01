import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/profile_card.dart';

class Profiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: <Widget>[
        ProfileCard(
          'Trey Sumida',
          'Student',
          'I am a student at UH Manoa.',
          [
            'Software Development',
            'Software Engineering',
          ],
        ),
        ProfileCard(
          'Ken Tung',
          'Student',
          'I am a student at UH Manoa. I like to code and have fun.',
          [
            'Software Development',
            'Software Engineering',
          ],
        ),
      ],
    );
  }
}
