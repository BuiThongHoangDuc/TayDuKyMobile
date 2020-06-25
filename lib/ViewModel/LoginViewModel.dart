import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mobiletayduky/Model/LoginInfo.dart';
import 'package:mobiletayduky/Model/LoginUserModel.dart';
import 'package:mobiletayduky/Repository/UserRepository.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginViewModel extends Model {

  final IUserRepository loginRepo = UserRepository();

  LoginInfo _infoModel;
  LoginUserModel _userModel;

  LoginInfo get infoModel => _infoModel;
  LoginUserModel get userModel => _userModel;

  Future<String> SignIn(String email, String password) async {
    _infoModel = new LoginInfo(
      userEmail: email,
      userPassword: password,
    );

    String loginJson = jsonEncode(_infoModel.toJson());

    _userModel = await loginRepo.signIn(loginJson);

    if(_userModel != null) return "Ok";
    else return "Not Found";
  }
}