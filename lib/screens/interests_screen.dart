import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/category_info.dart';

class InterestsScreen extends StatelessWidget {
  final String interestName;

  InterestsScreen(this.interestName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(interestName),
      ),
      body: CategoryInfo(interestName),
    );
  }
}
