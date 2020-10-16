import 'package:bowfolios/widgets/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplaySearch extends StatefulWidget {
  final _interests;

  DisplaySearch(this._interests);

  @override
  _DisplaySearchState createState() => _DisplaySearchState();
}

class _DisplaySearchState extends State<DisplaySearch> {
  final firestoreInstance = FirebaseFirestore.instance;
  List<String> _users = new List<String>();
  Widget _profileWidget = CircularProgressIndicator();

  Future<void> _getProfiles() async {
    List<String> userIDs = new List<String>();

    for (var i = 0; i < widget._interests.length; i++) {
      await firestoreInstance
          .collection("profilesinterest")
          .where("interest", isEqualTo: widget._interests[i])
          .get()
          .then((value) {
        if (value.docs.length != 0) {
          value.docs.forEach((element) async {
            if (!userIDs.contains(element.data()["profile"])) {
              userIDs.add(element.data()["profile"]);
            }
          });
        }
      });
    }
    setState(() {
      _users = userIDs;
    });
  }

  void _getWidgets() async {
    List<Widget> proflist = new List<Widget>();
    if (_users.length != 0) {
      for (var i = 0; i < _users.length; i++) {
        await firestoreInstance
            .collection("users")
            .doc(_users[i])
            .get()
            .then((value) {
          var data = value.data();
          var name = data["firstName"] + " " + data["lastName"];
          proflist.add(
            new ProfileCard(
              name,
              data["bio"],
              data["picture"],
              value.id,
            ),
          );
        });
      }
    } else {
      proflist.add(
        new Text("No profiles associated with this interest(s) selected"),
      );
    }

    setState(() {
      _profileWidget = Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 3,
          runSpacing: -10,
          children: proflist,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _getProfiles();
    _getWidgets();
    return _profileWidget;
  }
}
