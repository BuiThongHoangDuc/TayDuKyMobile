import 'dart:convert';
import 'dart:io';

import 'package:mobiletayduky/Helper/APIHelper.dart';
import 'package:mobiletayduky/Model/ScenarioAddModel.dart';
import 'package:mobiletayduky/Model/ScenarioBasicModel.dart';
import 'package:http/http.dart' as http;
import 'package:mobiletayduky/Model/ScenarioEditModel.dart';

abstract class IScenarioRepository {
  Future<List<ScenarioBasicModel>> getScenarios();

  Future<dynamic> addScenarios(String addScenarioJson);

  Future<List<ScenarioBasicModel>> searchScenarios(String search);

  Future<dynamic> deleteScenario(int id);

  Future<ScenarioEditModel> getScenariosByID(int id);

  Future<dynamic> editScenario(int id, String editScenarioJson);
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
    } else
      return list;
  }

  @override
  Future<List<ScenarioBasicModel>> searchScenarios(String search) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var queryParameters = {'ScenarioName': search};
    var uri = Uri.http(urlAPI, "/api/Scenarios", queryParameters);
    http.Response response = await http.get(uri, headers: header);
    List<ScenarioBasicModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => ScenarioBasicModel.fromJson(data))
          .toList();
      return list;
    } else
      return list;
  }

  @override
  Future<dynamic> addScenarios(String addScenarioJson) async {
    String urlAPI = APIHelper.apiAddScenario();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    http.Response response =
        await http.post(urlAPI, headers: header, body: addScenarioJson);
    if (response.statusCode == 204) {
      return "OK";
    } else {
      return "BadRequest";
    }
  }

  Future<dynamic> deleteScenario(int id) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/Scenarios/$id");
    http.Response response = await http.delete(uri, headers: header);
    if (response.statusCode == 204) {
      return "OK";
    } else if (response.statusCode == 404) {
      return "Not Found";
    } else {
      return "ERROR Database";
    }
  }

  @override
  Future<ScenarioEditModel> getScenariosByID(int id) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/Scenarios/$id");
    http.Response response = await http.get(uri, headers: header);
    ScenarioEditModel scenario;
    if (response.statusCode == 200) {
      Map<String, dynamic> sc = json.decode(response.body);
      scenario = ScenarioEditModel.fromJson(sc);
      return scenario;
    } else
      return scenario;
  }

  @override
  Future<dynamic> editScenario(int id, String editScenarioJson) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/Scenarios/$id");
    http.Response response =
        await http.put(uri, headers: header, body: editScenarioJson);
    print(response.body);
    if (response.statusCode == 200) {
      int idScenario = json.decode(response.body);
      return idScenario;
    } else if (response.statusCode == 404) {
      return "Not Found";
    } else {
      return "ERROR Database";
    }
  }
}
