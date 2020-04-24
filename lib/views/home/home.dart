import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:plant_project/Widgets/Button.dart';
import 'package:plant_project/animations/homeAnimation.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> with TickerProviderStateMixin {
  AnimationController _loginButtonController;
  var animationStatus;

  @override
  void initState() {
    animationStatus = 1;
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _loginButtonController.forward();
      await _loginButtonController.reverse();
    } on TickerCanceled {}
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Are you sure you want to exit?'),
            content: new Text('Uploaded photo will be lost.'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () =>
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                child: new Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return (new WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: new Scaffold(
          body: new Container(
            height: deviceHeight,
            width: deviceWidth,
            decoration: new BoxDecoration(
                //image: backgroundImage,
                ),
            child: new Container(
                decoration: new BoxDecoration(
                    gradient: new LinearGradient(
                  colors: <Color>[
                    /*const Color.fromRGBO(162, 146, 199, 0.8),
                    const Color.fromRGBO(51, 51, 63, 0.9),*/
                    Color(0xffb1d182),
                    Color(0xfff4f1e9)
                  ],
                  stops: [0.2, 1.0],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(0.0, 1.0),
                )),
                child: ListView(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Stack(children: <Widget>[
                          //new Button(),*/
                          animationStatus == 0
                              ? new Padding(
                                  padding: const EdgeInsets.only(bottom: 50.0),
                                  child: new InkWell(
                                    onTap: () {
                                      setState(() {
                                        animationStatus = 1;
                                      });
                                      _playAnimation();
                                    },
                                  ),
                                )
                              : new StaggerAnimation(
                                  buttonController:
                                      _loginButtonController.view),
                        ]),
                        Container(
                          width: deviceWidth * 0.9,
                          child:
                              Image(image: AssetImage('assets/home_icon.png')),
                        ),
                        Container(
                            width: deviceWidth * 0.9,
                            child: Text(
                              'Plant Disease Classification',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'DancingScript',
                                  fontSize: 60,
                                  fontWeight: FontWeight.w700),
                            )),
                      ],
                    ),
                    //),
                    //new Spacer(),
                  ],
                )),
          ),
        ),
      ),
    ));
  }
}
