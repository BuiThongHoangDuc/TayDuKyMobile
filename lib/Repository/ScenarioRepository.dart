import 'dart:convert';
import 'dart:io';

import 'package:mobiletayduky/Helper/APIHelper.dart';
import 'package:mobiletayduky/Model/ScenarioBasicModel.dart';
import 'package:http/http.dart' as http;

abstract class IScenarioRepository {
  Future<List<ScenarioBasicModel>> getScenarios();
  Future<dynamic> addScenarios(String addScenarioJson);
  Future<List<ScenarioBasicModel>> searchScenarios(String search);
}

class ScenarioRepository implements IScenarioRepository {
  @override
  Future<List<ScenarioBasicModel>> getScenarios() async {
    String urlAPI = APIHelper.apiListScenario();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.get(urlAPI, headers: header);
    List<ScenarioBasicModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => ScenarioBasicModel.fromJson(data))
          .toList();
      return list;
    } else return list;
  }

  @override
  Future<List<ScenarioBasicModel>> searchScenarios(String search) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var queryParameters ={
      'ScenarioName': search
    };
    var uri = Uri.http(urlAPI,"/api/Scenarios",queryParameters);
    http.Response response = await http.get(uri, headers: header);
    List<ScenarioBasicModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => ScenarioBasicModel.fromJson(data))
          .toList();
      return list;
    } else return list;
  }

  @override
  Future<dynamic> addScenarios(String addScenarioJson) async {
    String apiSignIn = APIHelper.apiAddScenario();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    http.Response response =
        await http.post(apiSignIn, headers: header, body: addScenarioJson);
    print(response.statusCode);
    if (response.statusCode == 204) {
      return "OK";
    } else {
      return "BadRequest";
    }
  }


}
