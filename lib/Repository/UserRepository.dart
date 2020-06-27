import 'dart:convert';
import 'dart:io';

import 'package:mobiletayduky/Helper/APIHelper.dart';
import 'package:http/http.dart' as http;
import 'package:mobiletayduky/Model/LoginUserModel.dart';

abstract class IUserRepository {
  Future<dynamic> signIn(String loginJson);
}

class UserRepository implements IUserRepository {
  @override
  Future<dynamic> signIn(String loginJson) async {
    String apiSignIn = APIHelper.apiLogin();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response =
        await http.post(apiSignIn, headers: header, body: loginJson);
    Map<String, dynamic> userSimpleInfo = jsonDecode(response.body);
    if (response.statusCode == 404) {
      return null;
    } else {
      LoginUserModel userModel;
      userModel = LoginUserModel.fromJson(userSimpleInfo);
      return userModel;
    }
  }
}
