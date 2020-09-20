import 'package:flutter/material.dart';
import 'package:bowfolios/screens/interests_screen.dart';

class InterestCard extends StatelessWidget {
  final String interest;

  InterestCard(this.interest);

  void selectInterest(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return InterestsScreen(interest);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectInterest(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Text(
          interest,
          textAlign: TextAlign.center,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.7),
              Colors.lightGreen,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
