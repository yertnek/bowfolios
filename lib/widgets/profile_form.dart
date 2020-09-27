import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  bool _uploading = false;
  File _pickedImage;
  String _username;
  String _firstName;
  String _lastName;
  String _email;
  String _bio;
  String _title;
}
