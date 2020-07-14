import 'dart:convert';
import 'dart:io';

import 'package:mobiletayduky/Helper/APIHelper.dart';
import 'package:http/http.dart' as http;
import 'package:mobiletayduky/Model/ListEquipmentInScenarioModel.dart';

abstract class IEquipmentInScenarioRepo {
  Future<dynamic> addEquipmentToScenario(
      int scenarioID, String addEquipmentToScenarioJson);

  Future<List<ListEquipmentInScenarioModel>> getEquipmentInScenario(
      int scenarioID);

  Future<List<ListEquipmentInScenarioModel>> getEquipmentInScenarioAll();
}

class EquipmentInScenarioRepo implements IEquipmentInScenarioRepo {
  @override
  Future addEquipmentToScenario(
      int scenarioID, String addEquipmentToScenarioJson) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri =
        Uri.http(urlAPI, "/api/Scenarios/$scenarioID/EquipmentInScenario");
    http.Response response =
        await http.post(uri, headers: header, body: addEquipmentToScenarioJson);
    print(response.statusCode);
    if (response.statusCode == 204) {
      return "Ok";
    } else if (response.statusCode == 409)
      return "Conflict";
    else
      return "Bad Request";
  }

  @override
  Future<List<ListEquipmentInScenarioModel>> getEquipmentInScenario(
      int scenarioID) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/Scenarios/$scenarioID/EquipmentInScenario");
    http.Response response = await http.get(uri, headers: header);
    List<ListEquipmentInScenarioModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => ListEquipmentInScenarioModel.fromJson(data))
          .toList();
      return list;
    } else
      return list;
  }

  @override
  Future<List<ListEquipmentInScenarioModel>> getEquipmentInScenarioAll() async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/EquipmentInScenarios");
    http.Response response = await http.get(uri, headers: header);
    List<ListEquipmentInScenarioModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => ListEquipmentInScenarioModel.fromJson(data))
          .toList();
      return list;
    } else
      return list;
  }
}
