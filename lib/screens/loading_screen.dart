import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shimmer/shimmer.dart';
import 'home_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();

    _appDelay().then((status) {
      if (status) {
        _navigateToHome();
      }
    });
  }

  Future<bool> _appDelay() async {
    await Future.delayed(Duration(milliseconds: 5000), () {});

    return true;
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/images/hawaiilogo.png'),
          ),
          Container(
              alignment: Alignment.center,
              child: Shimmer.fromColors(
                baseColor: Color.fromARGB(1000, 12, 100, 63),
                highlightColor: Color.fromARGB(1000, 0, 0, 0),
                child: Container(
                  child: Text(
                    "BowFolios",
                    style: TextStyle(
                      fontSize: 80.0,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
