import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryInfo extends StatefulWidget {
  final String interestName;

  CategoryInfo(this.interestName);

  @override
  _CategoryInfoState createState() => _CategoryInfoState();
}

class _CategoryInfoState extends State<CategoryInfo> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("Profiles"),
        Divider(
          color: Colors.black,
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}
