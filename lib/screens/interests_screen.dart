import 'package:flutter/material.dart';

import 'package:bowfolios/widgets/category_info.dart';

class InterestsScreen extends StatelessWidget {
  final String interestName;
  final List<String> userIDs;
  final List<String> projIDs;

  InterestsScreen(this.interestName, this.userIDs, this.projIDs);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(interestName),
      ),
      body: CategoryInfo(interestName, userIDs, projIDs),
    );
  }
}
