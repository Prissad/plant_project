import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plant_project/api/api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Picture extends StatefulWidget {
  @override
  _PictureState createState() => _PictureState();
}

class _PictureState extends State<Picture> {
  @override
  File im;
  bool first;
  String result;
  bool _isLoading = false;

  @override
  void initState() {
    first = true;
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

  Future<bool> _onWillPop() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    // TODO: implement build
    return new WillPopScope(
        onWillPop: _onWillPop,
        child: SafeArea(
            child: Scaffold(
                backgroundColor: /*Color.fromRGBO(250, 205, 211, 1)*/
                    Color(0xffb1d182),
                appBar: AppBar(
                  backgroundColor: /*Colors.pink*/
                      Color(0xff2b463c),
                  centerTitle: true,
                  title: Text(
                    'Take or Upload your Picture :',
                    style: TextStyle(color: Color(0xfff4f1e9)),
                  ),
                  leading: new IconButton(
                    icon: new Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                  ),
                ),
                body: Stack(children: <Widget>[
                  Container(
                    height: deviceHeight,
                    width: deviceWidth,
                    /*decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/auto.jpg'), fit: BoxFit.cover),
                ),*/
                  ),
                  Positioned(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: (first)
                                    ? <Widget>[
                                        SizedBox(height: deviceHeight * 0.1),
                                        Center(
                                            child: Card(
                                                color: Color(0xfff4f1e9),
                                                elevation: 4.0,
                                                margin: EdgeInsets.only(
                                                    left: 20, right: 20),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        SizedBox(height: 20.0),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            Text(
                                                                'Take a Picture'),
                                                            Text(
                                                                'Upload a Picture'),
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
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets
                                                                        .all(
                                                                            10),
                                                                    child: Icon(
                                                                        Icons
                                                                            .camera_alt,
                                                                        size:
                                                                            50.0),
                                                                    height: 50,
                                                                    width: 50,
                                                                  )),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    setImage();
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    margin: EdgeInsets
                                                                        .all(
                                                                            10),
                                                                    child: Icon(
                                                                        Icons
                                                                            .file_upload,
                                                                        size:
                                                                            50.0),
                                                                    height: 50,
                                                                    width: 50,
                                                                  )),
                                                            ]),
                                                        Container(
                                                          child: im == null
                                                              ? Icon(Icons.sync)
                                                              : ColorFiltered(
                                                                  colorFilter: ColorFilter.mode(
                                                                      Colors
                                                                          .black
                                                                          .withOpacity(_isLoading
                                                                              ? 0.9
                                                                              : 0),
                                                                      BlendMode
                                                                          .color),
                                                                  child: Image
                                                                      .file(
                                                                    im,
                                                                    height:
                                                                        deviceHeight *
                                                                            0.45,
                                                                  )),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            /////////////////// Submit//////////////////
                                                            ButtonTheme(
                                                              buttonColor:
                                                                  _isLoading
                                                                      ? Colors
                                                                          .grey
                                                                      : Color(
                                                                          0xff688f4e),
                                                              disabledColor:
                                                                  Colors.grey,
                                                              minWidth: 50.0,
                                                              child:
                                                                  RaisedButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            80.0)),
                                                                splashColor:
                                                                    _isLoading
                                                                        ? Colors.red[
                                                                            50]
                                                                        : Colors
                                                                            .red,
                                                                disabledColor:
                                                                    Colors.grey,
                                                                onPressed:
                                                                    () async {
                                                                  if (!_isLoading) {
                                                                    if (im ==
                                                                        null) {
                                                                      Alert(
                                                                        context:
                                                                            context,
                                                                        type: AlertType
                                                                            .error,
                                                                        title:
                                                                            'Please take a Picture',
                                                                        buttons: [
                                                                          DialogButton(
                                                                            child:
                                                                                Text('OK'),
                                                                            onPressed:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            color:
                                                                                Color(0xff688f4e),
                                                                          ),
                                                                        ],
                                                                      ).show();
                                                                    } else {
                                                                      setState(
                                                                          () {
                                                                        _isLoading =
                                                                            true;
                                                                      });
                                                                      var data =
                                                                          {
                                                                        "image":
                                                                            base64Encode(im.readAsBytesSync())
                                                                      };
                                                                      var res =
                                                                          await CallApi()
                                                                              .postData(data);
                                                                      result = (res
                                                                              .data)[
                                                                          'result'];
                                                                      setState(
                                                                          () {
                                                                        first =
                                                                            false;
                                                                        _isLoading =
                                                                            false;
                                                                      });
                                                                    }
                                                                  }
                                                                },
                                                                child: Text(_isLoading
                                                                    ? 'Loading ...'
                                                                    : 'Submit'),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ]),
                                                ))),
                                      ]
                                    ///////////////////////////////Second Page/////////////////////////////////////////////
                                    : <Widget>[
                                        SizedBox(height: deviceHeight * 0.1),
                                        Center(
                                            child: Card(
                                                color: Color(0xfff4f1e9),
                                                elevation: 4.0,
                                                margin: EdgeInsets.only(
                                                    left: 20, right: 20),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              'Result : ',
                                                              style: TextStyle(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              result != null
                                                                  ? result
                                                                  : 'No result',
                                                              style: TextStyle(
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                deviceHeight *
                                                                    0.08),
                                                        GestureDetector(
                                                          child: Container(
                                                              child: im == null
                                                                  ? Icon(Icons
                                                                      .sync)
                                                                  : Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              Colors.red,
                                                                          width:
                                                                              5.0,
                                                                        ),
                                                                      ),
                                                                      child: Image
                                                                          .file(
                                                                        im,
                                                                        height: deviceHeight *
                                                                            0.3,
                                                                      ),
                                                                    )),
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return Dialog(
                                                                    elevation:
                                                                        16,
                                                                    child: Image
                                                                        .file(
                                                                            im));
                                                              },
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                deviceHeight *
                                                                    0.05),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            /////////////////// Back//////////////////
                                                            ButtonTheme(
                                                              buttonColor:
                                                                  /*Colors.grey,*/
                                                                  Color(
                                                                      0xff688f4e),
                                                              minWidth: 50.0,
                                                              child:
                                                                  RaisedButton(
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            80.0)),
                                                                splashColor:
                                                                    Colors.red,
                                                                onPressed: () {
                                                                  setState(() {
                                                                    first =
                                                                        true;
                                                                  });
                                                                },
                                                                child: Text(
                                                                    'Back'),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ]),
                                                ))),
                                      ]),
                          )))
                ]))));
  }
}
