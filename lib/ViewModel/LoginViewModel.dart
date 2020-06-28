import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/LoginInfo.dart';
import 'package:mobiletayduky/Model/LoginUserModel.dart';
import 'package:mobiletayduky/Repository/UserRepository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends Model {
  final IUserRepository loginRepo = UserRepository();

  LoginInfo _infoModel;
  LoginUserModel _userModel;

  LoginInfo get infoModel => _infoModel;

  LoginUserModel get userModel => _userModel;

  //Valite ALL INPUT
  Validate _email = Validate(null, null);
  Validate _pass = Validate(null, null);

  //Getters
  Validate get email => _email;

  Validate get pass => _pass;

  //Setters
  void changeEmail(String value) {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      _email = Validate(value, null);
    } else {
      _email = Validate(null, "Invalid Email Input");
    }
    notifyListeners();
  }

  //Setters
  void changePassword(String value) {
    if (value.length <= 3) {
      _pass = Validate(null, "Input Must Be Grater Than 3");
    } else {
      _pass = Validate(value, null);
    }
    notifyListeners();
  }

  Future<bool> login() async {
    if (_email.value == null || _pass.value == null)
      return Future<bool>.value(false);
    else {
      _infoModel = new LoginInfo(
        userEmail: _email.value.trim(),
        userPassword: _pass.value.trim(),
      );
      String loginJson = jsonEncode(_infoModel.toJson());

      _userModel = await loginRepo.signIn(loginJson);
      if (_userModel != null) {
        SharedPreferences pref = await SharedPreferences.getInstance();

        pref.setString("usName", _userModel.userName);
        pref.setInt("usId", _userModel.userId);
        pref.setString("usImage", _userModel.userImage);
        pref.setString("usEmail", _userModel.userEmail);
        pref.setInt("usRole", _userModel.userRole);
        return Future<bool>.value(true);
      } else {
        return Future<bool>.value(false);
      }
    }
  }
}
