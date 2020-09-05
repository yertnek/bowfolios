import 'package:flutter/material.dart';

class InterestCard extends StatelessWidget {
  final String interest;

  InterestCard(this.interest);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Text(interest),
      color: Colors.white,
    );
  }
}
