import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/interest_card.dart';

class Interests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      children: <Widget>[
        InterestCard('Software Development'),
        InterestCard('Software Engineering'),
      ],
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
