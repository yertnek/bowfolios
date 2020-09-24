import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProjectForm extends StatefulWidget {
  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  File _pickedImage;

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
          ],
        );
      },
    );
  }

  void _pickImage(ImageSource opt) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: opt);
    final pickedImageFile = File(pickedImage.path); //
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
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
                return null;
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
                return null;
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
                return null;
              },
            ),
            Row(
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
            RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, otherwise false.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.

                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
