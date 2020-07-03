import 'dart:convert';
import 'dart:io';

import 'package:mobiletayduky/Helper/APIHelper.dart';
import 'package:mobiletayduky/Model/AddEquipmentModel.dart';
import 'package:mobiletayduky/Model/EquipmentBasicModel.dart';
import 'package:http/http.dart' as http;
abstract class IEquipmentRepository {
  Future<List<EquipmentBasicModel>> getListEquipment();
  Future<dynamic> addEquipment(String addEquipmentJson);
  Future<List<EquipmentBasicModel>> searchListEquipment(String eName);
  Future<dynamic> deleteEquipment(int id);
  Future<AddEquipmentModel> getEquipmentsByID(int id);
}

class EquipmentRepository implements IEquipmentRepository {
  @override
  Future<List<EquipmentBasicModel>> getListEquipment() async {
    String urlAPI = APIHelper.apiListEquipment();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };

    http.Response response = await http.get(urlAPI, headers: header);
    List<EquipmentBasicModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => EquipmentBasicModel.fromJson(data))
          .toList();
      print(list[0].equipmentImage);
      return list;
    } else
      return list;
  }

  @override
  Future<List<EquipmentBasicModel>> searchListEquipment(String eName) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var queryParameters ={
      'eName': eName
    };
    var uri = Uri.http(urlAPI,"/api/Equipments",queryParameters);
    http.Response response = await http.get(uri, headers: header);
    List<EquipmentBasicModel> list;
    if (response.statusCode == 200) {
      list = (json.decode(response.body) as List)
          .map((data) => EquipmentBasicModel.fromJson(data))
          .toList();
      return list;
    } else return list;
  }

  @override
  Future addEquipment(String addEquipmentJson) async {
    String apiSignIn = APIHelper.apiAddEquipment();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    http.Response response =
        await http.post(apiSignIn, headers: header, body: addEquipmentJson);
    print(response.statusCode);
    if (response.statusCode == 204) {
      return "OK";
    } else {
      return "BadRequest";
    }
  }

  Future<dynamic> deleteEquipment(int id) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/Equipments/$id");
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
  Future<AddEquipmentModel> getEquipmentsByID(int id) async {
    String urlAPI = APIHelper.apiProject();
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json",
    };
    var uri = Uri.http(urlAPI, "/api/Equipments/$id");
    http.Response response = await http.get(uri, headers: header);
    AddEquipmentModel equipment;
    if (response.statusCode == 200) {
      Map<String, dynamic> sc =json.decode(response.body);
      equipment = AddEquipmentModel.fromJson(sc);
      return equipment;
    } else
      return equipment;
  }

}
