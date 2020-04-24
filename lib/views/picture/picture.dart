import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Picture extends StatefulWidget {
  @override
  _PictureState createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  @override
  File im;

  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      im = image;
    });
  }

  Future setImage() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      im = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromRGBO(250, 205, 211, 1),
            appBar: AppBar(
              actions: <Widget>[Icon(Icons.add_alert)],
              backgroundColor: Colors.pink,
              centerTitle: true,
              title: Text('Take or Upload your picture please :'),
            ),
            body: Stack(children: <Widget>[
              Container(
                height: deviceHeight,
                width: deviceWidth,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/auto.jpg'), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              SizedBox(height: deviceHeight * 0.1),
                              Center(
                                  child: Card(
                                      elevation: 4.0,
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              SizedBox(height: 20.0),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: <Widget>[
                                                  Text('Take a Picture'),
                                                  Text('Upload a Picture'),
                                                ],
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: <Widget>[
                                                    GestureDetector(
                                                        onTap: () {
                                                          getImage();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Icon(
                                                              Icons.camera_alt,
                                                              size: 50.0),
                                                          height: 50,
                                                          width: 50,
                                                        )),
                                                    GestureDetector(
                                                        onTap: () {
                                                          setImage();
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          child: Icon(
                                                              Icons.file_upload,
                                                              size: 50.0),
                                                          height: 50,
                                                          width: 50,
                                                        )),
                                                  ]),
                                              Container(
                                                  child: im == null
                                                      ? Icon(Icons.sync)
                                                      : Image.file(
                                                          im,
                                                          height: deviceHeight *
                                                              0.4,
                                                        )),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  /////////////////// Submit//////////////////
                                                  ButtonTheme(
                                                    buttonColor: Colors.grey,
                                                    minWidth: 50.0,
                                                    child: RaisedButton(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          80.0)),
                                                      splashColor: Colors.red,
                                                      onPressed: () async {
                                                        if (im == null) {
                                                          Alert(
                                                            context: context,
                                                            type:
                                                                AlertType.error,
                                                            title:
                                                                'Please take a Picture',
                                                            buttons: [
                                                              DialogButton(
                                                                  child: Text(
                                                                      'OK'),
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  gradient:
                                                                      LinearGradient(
                                                                          colors: [
                                                                        Color.fromRGBO(
                                                                            116,
                                                                            116,
                                                                            191,
                                                                            1.0),
                                                                        Color.fromRGBO(
                                                                            52,
                                                                            138,
                                                                            199,
                                                                            1.0)
                                                                      ])),
                                                            ],
                                                          ).show();
                                                        }
                                                      },
                                                      child: Text('Submit'),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ]),
                                      ))),
                            ]),
                      )))
            ])));
  }
}
