import 'package:flutter_login_sample/data/database_helper.dart';
import 'package:flutter_login_sample/models/user.dart';

abstract class SignUpContract {
  void onSignUpSuccess(bool value);
  void onSignUpError(String error);
}

class SignUpPagePresenter {
  SignUpContract _view;
  var api = new DatabaseHelper();
  SignUpPagePresenter(this._view);

  doSignUp(User user) {
    api
        .saveUser(user)
        .then((res) => _view.onSignUpSuccess(res))
        .catchError((onError) => _view.onSignUpError(onError.toString()));
  }
}
