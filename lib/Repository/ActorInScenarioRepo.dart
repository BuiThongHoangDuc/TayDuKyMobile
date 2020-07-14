import 'dart:convert';
import 'dart:io';

import 'package:mobiletayduky/Helper/APIHelper.dart';
import 'package:http/http.dart' as http;
import 'package:mobiletayduky/Model/EditActorToScenarioModel.dart';

abstract class IActorInScenarioRepo {
  Future<dynamic> deleteAS(int id);
  Future<EditActorToScenarioModel> getAISByID(int id);
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

}