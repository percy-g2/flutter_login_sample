import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_login_sample/pages/login/login_page.dart';
import 'package:simple_permissions/simple_permissions.dart';

// This is the Splash Screen
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    getExternalStoragePermission();
    super.initState();
    _animationController = new AnimationController(
        vsync: this,
        duration: new Duration(milliseconds: 500)
    );
    _animation = new CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animation.addListener(()=> this.setState((){}));
    _animationController.forward();

    Timer(Duration(seconds: 10), (){
      _checkPermission();
    });
  }

  _checkPermission() async {
    bool connectionResult = await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
    if (connectionResult) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      exit(0);
    }
  }

  void getExternalStoragePermission() {
    SimplePermissions.requestPermission(Permission.WriteExternalStorage).then((value) {
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              child: new Image.asset(
                'images/splashscreenbg.png',
                fit: BoxFit.cover,
              )
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlutterLogo(
                          size: _animation.value * 100.0,
                        ),
                        Padding(padding: EdgeInsets.only(top: 10.0)),
                        Text("Sample Login", style: TextStyle(color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w300),)
                      ],
                    ),
                  ),
                ),
              ]
          )
        ],
      ),
    );
  }
}