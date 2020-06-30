import 'dart:convert';
import 'dart:io';

import 'package:mobiletayduky/Helper/APIHelper.dart';
import 'package:http/http.dart' as http;
import 'package:mobiletayduky/Model/LoginUserModel.dart';
import 'package:mobiletayduky/Model/UserBasicModel.dart';

abstract class IUserRepository {
  Future<dynamic> signIn(String loginJson);
  Future<List<UserBasicModel>> getListUser();
  Future<List<UserBasicModel>> searchListUser(String userName);
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

  @override
  Future<List<UserBasicModel>> getListUser() async {
    String urlAPI = APIHelper.apiListActor();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.get(urlAPI, headers: header);
    List<UserBasicModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => UserBasicModel.fromJson(data))
          .toList();
      return list;
    } else return list;
  }

  @override
  Future<List<UserBasicModel>> searchListUser(String userName) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var queryParameters ={
      'usName': userName
    };
    var uri = Uri.http(urlAPI,"/api/Users",queryParameters);
    http.Response response = await http.get(uri, headers: header);
    List<UserBasicModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => UserBasicModel.fromJson(data))
          .toList();
      return list;
    } else return list;
  }

}
