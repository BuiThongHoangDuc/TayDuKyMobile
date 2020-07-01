import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/AddEquipmentModel.dart';
import 'package:mobiletayduky/Repository/EquipmentRepository.dart';
import 'package:mobiletayduky/View/EquipmentPage.dart';
import 'package:mobiletayduky/ViewModel/EquipmentViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart' as path;

class AddEquipmentViewModel extends Model {
  final EquipmentRepository equipRepo = new EquipmentRepository();
  AddEquipmentModel _addModel;
  File _image;

  File get image => _image;
  String _defaultImage =
      'https://firebasestorage.googleapis.com/v0/b/journey-to-the-west-3db0d.appspot.com/o/noimage.jpg?alt=media&token=e1a3652f-3c98-4230-a6c9-e4e5b1fac69a';

  String get defaultImage => _defaultImage;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isReady = true;

  //Valite ALL INPUT
  Validate _name = Validate(null, null);
  Validate _description = Validate(null, null);
  Validate _quantity = Validate(null, null);

  //Getters
  Validate get name => _name;

  Validate get description => _description;

  Validate get quantity => _quantity;

  //Setters
  void changeName(String value) {
    if (value.length <= 3 || value.length > 20) {
      _name = Validate(null, "Input Must Be > 3 character and < 20 character");
    } else {
      _name = Validate(value, null);
    }
    notifyListeners();
  }

  //Setters
  void changeComment(String value) {
    if (value.length <= 3 || value.length > 150) {
      _description =
          Validate(null, "Input Must Be > 3 character and < 150 character");
    } else {
      _description = Validate(value, null);
    }
    notifyListeners();
  }

  //Setters
  void changeQuantity(String value) {
    var regex = r'^\d+$';
    RegExp regExp = new RegExp(regex);
    if (!regExp.hasMatch(value)) {
      _quantity = Validate(null, "Input Must Be Integer");
    } else if (int.parse(value) > 999) {
      _quantity = Validate(null, "Input Must < 999");
    } else {
      _quantity = Validate(value, null);
    }
    notifyListeners();
  }

  Future getMyImage() async {
    var pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    notifyListeners();
  }

  void addEquipment(BuildContext context) async {
    _isReady = true;
    if (_name.value == null) {
      changeName("");
      _isReady = false;
    }
    if (_description.value == null) {
      changeComment("");
      _isReady = false;
    }
    if (_quantity.value == null) {
      changeQuantity("");
      _isReady = false;
    }

    if (_isReady == true) {
      _isLoading = true;
      notifyListeners();

      String nowImage;
      if (_image != null) {
        var url = await upLoadImage();
        nowImage = url.toString();
      } else
        nowImage = defaultImage;

      _addModel = new AddEquipmentModel(
          eqID: 0,
          eqDes: _description.value,
          eqImage: nowImage,
          eqName: _name.value,
          eqQuantity: int.parse(_quantity.value));

      String addScenarioJson = jsonEncode(_addModel.toJson());
      String status = await equipRepo.addEquipment(addScenarioJson);
      if(status == "BadRequest") {
        _isLoading = false;
        _name = Validate(null, "Name Is Already Exist");
        Fluttertoast.showToast(
          msg: "Add Equipment Fail",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
        notifyListeners();
      }
      else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) =>
                  EquipmentPage(
                    equipVM: EquipmentViewModel(),
                  ),
            ),
                (Route<dynamic> route) => false);
        Fluttertoast.showToast(
          msg: "Add Equipment Success",
          textColor: Colors.green,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      }
    }
  }

  Future<String> upLoadImage() async {
    String basename = path.basename(_image.path);
    StorageReference reference = FirebaseStorage.instance.ref().child(basename);
    StorageUploadTask uploadTask = reference.putFile(_image);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await reference.getDownloadURL();
    return url;
  }
}
