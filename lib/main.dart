import 'package:flutter/material.dart';

import 'screens/loading_screen.dart';

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
      ),
      home: LoadingScreen(),
    );
  }
}
