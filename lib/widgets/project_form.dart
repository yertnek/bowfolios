import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectForm extends StatefulWidget {
  @override
  _ProjectFormState createState() => _ProjectFormState();
}

class _ProjectFormState extends State<ProjectForm> {
  final _formKey = GlobalKey<FormState>();
  File _pickedImage;
  String _name;
  String _homePage;
  String _desc;

  final FirebaseStorage _storage =
      FirebaseStorage(storageBucket: 'gs://bowfolios-2b23c.appspot.com');
  StorageUploadTask _uploadTask;

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
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _startUpload() {
    if (_formKey.currentState.validate() && _pickedImage != null) {
      String filePath = 'images/${DateTime.now()}.png';
      setState(() {
        _uploadTask = _storage.ref().child(filePath).putFile(_pickedImage);
      });
      FirebaseFirestore.instance.collection('projects').add(
        {
          "Name": _name,
          "Home Page": _homePage,
          "Description": _desc,
          "Picture": filePath
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_uploadTask != null) {
      return StreamBuilder<StorageTaskEvent>(
        stream: _uploadTask.events,
        builder: (ctx, snapshot) {
          var event = snapshot?.data?.snapshot;
          double progressPercent =
              event != null ? event.bytesTransferred / event.totalByteCount : 0;
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (_uploadTask.isComplete) Text('Finished uploading!'),
                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.pause),
                    onPressed: _uploadTask.pause,
                  ),
                if (_uploadTask.isInProgress)
                  FlatButton(
                    child: Icon(Icons.play_arrow),
                    onPressed: _uploadTask.resume,
                  ),
                LinearProgressIndicator(value: progressPercent),
                Text('${(progressPercent * 100).toStringAsFixed(2)}%'),
              ],
            ),
          );
        },
      );
    } else {
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
                onPressed: _startUpload,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      );
    }
  }
}
