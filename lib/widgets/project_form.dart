import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'dart:io';
import 'dart:async';

import 'package:bowfolios/screens/home_screen.dart';

class ProjectForm extends StatefulWidget {
  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  bool _uploading = false;
  File _pickedImage;
  String _name;
  String _homePage;
  String _desc;
  var _interests = [];
  var _users = [];

  void _showAlertDialog(BuildContext context) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Would you like to use the camera or gallery?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Camera"),
              onPressed: () {
                _pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Gallery"),
              onPressed: () {
                _pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
            ),
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _pickImage(ImageSource opt) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: opt);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  Widget _multiSelectInterest() {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("interests").get(),
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

  Widget _multiSelectProfiles() {
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("users").get(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          var source = [];
          for (var i = 0; i < snapshot.data.documents.length; i++) {
            DocumentSnapshot ds = snapshot.data.documents[i];
            var data = ds.data();
            source.add(
              {
                "display": data["username"],
                "value": ds.id,
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
              title: Text("Profiles"),
              dataSource: source,
              textField: 'display',
              valueField: 'value',
              initialValue: _users,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please select one or more profiles';
                }
                setState(() {
                  _users = value;
                });
              },
              onSaved: (value) {
                if (value == null) return;
                setState(() {
                  _users = value;
                });
              });
        }
        return Text("No data");
      },
    );
  }

  void _startUpload() async {
    String projID;
    if (_formKey.currentState.validate() && _pickedImage != null) {
      setState(() {
        _uploading = true;
      });
      final ref = FirebaseStorage.instance
          .ref()
          .child('project_image')
          .child('${DateTime.now()}.jpg');

      await ref.putFile(_pickedImage).onComplete;

      final url = await ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('projects').add(
        {
          "name": _name,
          "home Page": _homePage,
          "description": _desc,
          "picture": url,
          "created": DateTime.now()
        },
      ).then(
        (value) {
          projID = value.id;
        },
      );
      for (var i = 0; i < _interests.length; i++) {
        await FirebaseFirestore.instance.collection('projectsinterests').add(
          {
            "project": projID,
            "interest": _interests[i],
          },
        );
        await FirebaseFirestore.instance.collection('profilesprojects').add(
          {
            "project": projID,
            "profile": _users[i],
          },
        );
      }
      setState(() {
        _uploading = false;
      });
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) {
          return HomeScreen();
        },
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_uploading) {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Project Name',
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the name of the project';
                    }
                    setState(() {
                      _name = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Description",
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a description for the project';
                    }
                    setState(() {
                      _desc = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Homepage Link",
                    hintText: 'https://bowfolios.github.io',
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter link for the project';
                    }
                    setState(() {
                      _homePage = value;
                    });
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          _pickedImage != null ? FileImage(_pickedImage) : null,
                    ),
                    FlatButton.icon(
                      textColor: Theme.of(context).secondaryHeaderColor,
                      onPressed: () => _showAlertDialog(context),
                      icon: Icon(Icons.image),
                      label: Text('Add Image'),
                    ),
                  ],
                ),
                _multiSelectInterest(),
                _multiSelectProfiles(),
                Center(
                  child: RaisedButton(
                    onPressed: _startUpload,
                    child: Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Text("Currently uploading data...");
  }
}
