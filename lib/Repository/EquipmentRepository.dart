import 'dart:convert';
import 'dart:io';

import 'package:mobiletayduky/Helper/APIHelper.dart';
import 'package:mobiletayduky/Model/EquipmentBasicModel.dart';
import 'package:http/http.dart' as http;
abstract class IEquipmentRepository {
  Future<List<EquipmentBasicModel>> getListEquipment();
  Future<List<EquipmentBasicModel>> searchListEquipment(String eName);
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
}
