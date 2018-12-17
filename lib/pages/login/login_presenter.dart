import 'package:flutter_login_sample/data/database_helper.dart';

abstract class LoginPageContract {
  void onLoginSuccess(bool value);
  void onLoginError(String error);
}

class LoginPagePresenter {
  LoginPageContract _view;
  var api = new DatabaseHelper();
  LoginPagePresenter(this._view);

  doLogin(String username, String password) {
    api
        .checkLogin(username, password)
        .then((value) => _view.onLoginSuccess(value))
        .catchError((onError) => _view.onLoginError(onError.toString()));
  }
}
