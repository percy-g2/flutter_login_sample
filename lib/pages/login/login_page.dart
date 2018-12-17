import 'package:flutter/material.dart';
import 'package:flutter_login_sample/pages/login/login_presenter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> implements LoginPageContract {
  BuildContext _ctx;
  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  String _username, _password;

  LoginPagePresenter _presenter;

  _LoginPageState() {
    _presenter = new LoginPagePresenter(this);
  }

  void _submit() {
    final form = formKey.currentState;

    if (form.validate()) {
      setState(() {
        _isLoading = true;
        form.save();
        _presenter.doLogin(_username, _password);
      });
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
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.red[900],
        textColor: Colors.white
    );
  }

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("Login"),
      textColor: Colors.white,
      color: Colors.blue,
    );
    var singUpBtn = new FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, "/signUp");
      },
      child: new Text(
        "No account yet? Create one",
        style: TextStyle(
          color: Colors.grey
        )
      )
    );
    var loginForm = new Column(
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
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(10.0),
                child: new TextFormField(
                  obscureText: _obscureText,
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(
                    labelText: "Password",
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
              )
            ],
          ),
        ),
        loginBtn,
        singUpBtn
      ],
    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Login")
      ),
      key: scaffoldKey,
      body: new Container(
        child: new Center(
          child: loginForm,
        ),
      ),
    );
  }

  @override
  void onLoginError(String error) {
    _showErrorToast(error);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void onLoginSuccess(bool value) async {
    if (value) {
      _showSuccessToast("Success");
      Navigator.of(context).pushNamed("/home");
    } else {
      _showErrorToast("Error");
    }
    setState(() {
      _isLoading = false;
    });
  }
}
