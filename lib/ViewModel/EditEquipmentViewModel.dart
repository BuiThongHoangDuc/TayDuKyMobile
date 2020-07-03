import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/AddEquipmentModel.dart';
import 'package:scoped_model/scoped_model.dart';

class EditEquipmentViewModel extends Model {
  AddEquipmentModel _editModel;

  EditEquipmentViewModel(AddEquipmentModel editModel){
    _editModel = editModel;
    getEquipInfo();
  }

  TextEditingController nameControl = TextEditingController();
  TextEditingController quantityControl = TextEditingController();
  TextEditingController desControl = TextEditingController();

  File _image;

  File get image => _image;
  String _defaultImage;

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

  void getEquipInfo() {
    nameControl.text = _editModel.eqName;
    _name = Validate(_editModel.eqName,null);
    quantityControl.text = _editModel.eqQuantity.toString();
    _quantity = Validate(_editModel.eqQuantity.toString(),null);
    desControl.text = _editModel.eqDes;
    _description = Validate(_editModel.eqDes,null);
    _defaultImage = _editModel.eqImage;
    notifyListeners();
  }

}