import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'dart:io';
import 'dart:async';

import 'package:bowfolios/screens/home_screen.dart';

class ProfileForm extends StatefulWidget {
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  var _firstNameControl;
  var _lastNameControl;
  var _bioControl;
  var _titleControl;
  String picID;
  bool _uploading = false;
  File _pickedImage;
  String _firstName;
  String _lastName;
  String _bio;
  String _title;
  String _picture;
  var _interests = [];

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

  void _startUpload() async {
    final userID = auth.currentUser.uid;
    if (_formKey.currentState.validate()) {
      setState(() {
        _uploading = true;
      });
      if (_pickedImage != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('profile_image')
            .child('${DateTime.now()}.jpg');

        await ref.putFile(_pickedImage).onComplete;

        final url = await ref.getDownloadURL();
        await FirebaseFirestore.instance
            .collection('users')
            .doc(auth.currentUser.uid)
            .update(
          {
            "picture": url,
          },
        );
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(auth.currentUser.uid)
          .update(
        {
          "firstName": _firstName,
          "lastName": _lastName,
          "bio": _bio,
          "title": _title,
        },
      );
      for (var i = 0; i < _interests.length; i++) {
        try {
          FirebaseFirestore.instance.collection('profilesinterest').where({
            "profile": userID,
            "interest": _interests[i],
          }).get();
        } catch (err) {
          print(err);
          await FirebaseFirestore.instance.collection('profilesinterest').add(
            {
              "profile": userID,
              "interest": _interests[i],
            },
          );
        }
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

  Future<void> _getData() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(auth.currentUser.uid)
        .get()
        .then((value) {
      setState(() {
        _firstName = value.data()['firstName'];
        _lastName = value.data()['lastName'];
        _bio = value.data()['bio'];
        _title = value.data()['title'];
        _picture = value.data()['picture'];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
    _firstNameControl = TextEditingController(text: _firstName);
    _lastNameControl = TextEditingController(text: _lastName);
    _bioControl = TextEditingController(text: _bio);
    _titleControl = TextEditingController(text: _title);
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
                  controller: _firstNameControl,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    hintText: _firstName,
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a first name.';
                    }
                    setState(() {
                      _firstName = value;
                    });
                  },
                ),
                TextFormField(
                  controller: _lastNameControl,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    hintText: _lastName,
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a last name.';
                    }
                    setState(() {
                      _lastName = value;
                    });
                  },
                ),
                TextFormField(
                  controller: _titleControl,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: _title,
                  ),
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a title.';
                    }
                    setState(() {
                      _title = value;
                    });
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Bio",
                    hintText: _bio,
                  ),
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 5,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter a bio.';
                    }
                    setState(() {
                      _bio = value;
                    });
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: _pickedImage != null
                          ? FileImage(_pickedImage)
                          : NetworkImage(_picture),
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
