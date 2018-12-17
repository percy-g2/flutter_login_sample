import 'package:flutter/material.dart';
import 'package:flutter_login_sample/models/user.dart';
import 'package:flutter_login_sample/pages/signup/sign_up_presenter.dart';
import 'dart:core';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => new _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> implements SignUpContract {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password, _rePassword;

  SignUpPagePresenter _presenter;

  _SignUpPageState() {
    _presenter = new SignUpPagePresenter(this);
  }

  void _submit() {
    if (identical(_password, _rePassword)) {
      final form = formKey.currentState;

      if (form.validate()) {
        setState(() {
          _isLoading = true;
          form.save();
          var user = new User(_username, _password);
          _presenter.doSignUp(user);
        });
      }
    } else{
      _showErrorToast("Password didn't match");
    }
  }

  void _showSuccessToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.green[900],
        textColor: Colors.white
    );
  }

  void _showErrorToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red[900],
        textColor: Colors.white
    );
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var signUpBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Sign Up"),
      textColor: Colors.white,
      color: Colors.blueAccent[700],
    );
    var signUpForm = new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  decoration: new InputDecoration(labelText: "Username")
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(labelText: "Password")
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  obscureText: _obscureText,
                  onSaved: (val) => _rePassword = val,
                  decoration: new InputDecoration(
                    labelText: "Confirm Password",
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                      child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        semanticLabel:
                        _obscureText ? 'show password' : 'hide password',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        signUpBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("SignUp"),
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: signUpForm,
        ),
      ),
    );
  }

  @override
  void onSignUpError(String error) {
    _showErrorToast(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onSignUpSuccess(bool value) async {
    if (value) {
      _showSuccessToast("Success");
      Navigator.pop(context,true);
    } else {
      _showErrorToast("Error");
    }
  }
}
