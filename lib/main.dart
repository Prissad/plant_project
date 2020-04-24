import 'package:flutter/material.dart';
import 'package:plant_project/views/home/home.dart';
import 'package:plant_project/views/picture/picture.dart';

void main() {
  runApp(
    MaterialApp(
      home: new MyApp(),
      title: 'Plant Disease Classification',
      debugShowCheckedModeBanner: false,
      routes: {
        //'/': (context) => Home(),
        '/picture': (context) => Picture()
      },
      //initialRoute: '/',
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State {
  @override
  void initState() {
    super.initState();
    new Future.delayed(
        const Duration(seconds: 4),
        () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Home()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(
              "assets/grow.gif",
              gaplessPlayback: true,
            )));
  }
}
