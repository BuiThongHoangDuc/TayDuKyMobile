import 'dart:convert';
import 'dart:io';

import 'package:mobiletayduky/Helper/APIHelper.dart';
import 'package:http/http.dart' as http;
import 'package:mobiletayduky/Model/EditActorToScenarioModel.dart';
import 'package:mobiletayduky/Model/ListActorInScenarioModel.dart';
import 'package:mobiletayduky/Model/ScenarioBasicModel.dart';

abstract class IActorInScenarioRepo {
  Future<dynamic> deleteAS(int id);
  Future<EditActorToScenarioModel> getAISByID(int id);
  Future<List<ScenarioBasicModel>> getScenariosNotDone(int id);
  Future<List<ScenarioBasicModel>> getScenariosDone(int id);
  Future<List<ListActorInScenarioModel>> getRoleInScenario(int id,int scenarioID);
  Future<dynamic> editAIS(int id, String editAISJson);
  Future<dynamic> deleteAIS(int id);
  
}

class ActorInScenarioRepo implements IActorInScenarioRepo {
  @override
  Future deleteAS(int id) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/ActorRoles/$id");
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
  Future editAIS(int id, String editAISJson) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/ActorRoles/$id");
    http.Response response =
        await http.put(uri, headers: header, body: editAISJson);
    print(response.body);
    if (response.statusCode == 200) {
      int idEquipment = json.decode(response.body);
      return idEquipment;
    } else if (response.statusCode == 404) {
      return "Not Found";
    } else {
      return "ERROR Database";
    };
  }

  @override
  Future<EditActorToScenarioModel> getAISByID(int id) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/ActorRoles/$id");
    http.Response response = await http.get(uri, headers: header);
    EditActorToScenarioModel ATS;
    if (response.statusCode == 200) {
      Map<String, dynamic> sc =json.decode(response.body);
      ATS = EditActorToScenarioModel.fromJson(sc);
      return ATS;
    } else
      return ATS;
  }

  @override
  Future deleteAIS(int id) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/ActorRoles/$id");
    http.Response response = await http.delete(uri, headers: header);
    print(response.statusCode);
    if (response.statusCode == 204) {
      return "OK";
    } else if (response.statusCode == 404) {
      return "Not Found";
    } else {
      return "ERROR Database";
    }
  }

  @override
  Future<List<ScenarioBasicModel>> getScenariosNotDone(int id) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/ActorRoles/$id/ListInProcess");
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
  Future<List<ScenarioBasicModel>> getScenariosDone(int id) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/ActorRoles/$id/ListDone");
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
  Future<List<ListActorInScenarioModel>> getRoleInScenario(int id, int scenarioID) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/ActorRoles/$id/$scenarioID");
    http.Response response = await http.get(uri, headers: header);
    List<ListActorInScenarioModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => ListActorInScenarioModel.fromJson(data))
          .toList();
      return list;
    } else
      return list;
  }

}