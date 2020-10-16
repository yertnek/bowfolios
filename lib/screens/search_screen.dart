import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

import 'package:bowfolios/widgets/main_drawer.dart';
import 'package:bowfolios/widgets/display_search.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  String username;
  var _interests = [];

  Future<void> _username() async {
    await firestoreInstance
        .collection("users")
        .doc(auth.currentUser.uid)
        .get()
        .then(
      (value) {
        setState(() {
          username = value.data()['username'];
        });
      },
    );
  }

  Widget _multiSelectInterest() {
    return FutureBuilder(
      future: firestoreInstance.collection("interests").get(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          var source = [];
          for (var i = 0; i < snapshot.data.documents.length; i++) {
            DocumentSnapshot ds = snapshot.data.documents[i];
            var data = ds.data();
            source.add(
              {
                "display": data["interest"],
                "value": data["interest"],
              },
            );
          }

          return MultiSelectFormField(
              autovalidate: false,
              chipBackGroundColor: Colors.green,
              chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
              dialogShapeBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
              title: Text("Interests"),
              dataSource: source,
              textField: 'display',
              valueField: 'value',
              initialValue: _interests,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter one or more interests';
                }
                setState(() {
                  _interests = value;
                });
              },
              onSaved: (value) {
                if (value == null) return;
                setState(() {
                  _interests = value;
                });
              });
        }
        return Text("No data");
      },
    );
  }

  void initState() {
    super.initState();
    _username();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Search'),
      ),
      drawer: MainDrawer(
        username: username,
      ),
      body: Wrap(
        spacing: 20,
        runSpacing: 20,
        alignment: WrapAlignment.center,
        children: [
          _multiSelectInterest(),
          DisplaySearch(_interests),
        ],
      ),
    );
  }
}
