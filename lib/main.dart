import 'package:bowfolios/screens/auth_screen.dart';
import 'package:flutter/material.dart';

import 'screens/loading_screen.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BowFolios',
      theme: ThemeData(
          primarySwatch: Colors.green,
          backgroundColor: Colors.green,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.green,
            textTheme: ButtonTextTheme.primary,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          )),
      home: AuthScreen(),
      //home: LoadingScreen(),
    );
  }
}
