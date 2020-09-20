import 'package:flutter/material.dart';

class InterestsScreen extends StatelessWidget {
  final String interestName;

  InterestsScreen(this.interestName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(interestName),
      ),
      body: Center(
        child: Text('Info for the category'),
      ),
    );
  }
}
