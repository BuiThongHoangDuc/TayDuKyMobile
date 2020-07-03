import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/ActorAddModel.dart';
import 'package:scoped_model/scoped_model.dart';

class EditActorViewModel extends Model {
  ActorAddModel _editModel;
  TextEditingController usName = TextEditingController();
  TextEditingController usAddress = TextEditingController();
  TextEditingController usPhone = TextEditingController();
  TextEditingController usDes = TextEditingController();
  TextEditingController usEmail = TextEditingController();
  TextEditingController usPass = TextEditingController();

  EditActorViewModel(ActorAddModel editModel) {
    this._editModel = editModel;
    getUserInfo();
  }
  File _image;

  File get image => _image;
  String _defaultImage;

  String get defaultImage => _defaultImage;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  bool _isReady = true;

  //Valite ALL INPUT
  Validate _name = Validate(null, null);
  Validate _pass = Validate(null, null);
  Validate _email = Validate(null, null);
  Validate _location = Validate(null, null);
  Validate _description = Validate(null, null);
  Validate _phoneNum = Validate(null, null);

  //Getters
  Validate get name => _name;

  Validate get pass => _pass;

  Validate get email => _email;

  Validate get location => _location;

  Validate get description => _description;

  Validate get phoneNum => _phoneNum;

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
  void changePass(String value) {
    if (value.length <= 3 || value.length > 20) {
      _pass = Validate(null, "Input Must Be > 3 character and < 20 character");
    } else {
      _pass = Validate(value, null);
    }
    notifyListeners();
  }

  //Setters
  void changeEmail(String value) {
    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" +
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";
    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      _email = Validate(value, null);
    } else {
      _email = Validate(null, "Invalid Email Input");
    }
    notifyListeners();
  }

  //Setters
  void changeLocation(String value) {
    if (value.length <= 3 || value.length > 50) {
      _location =
          Validate(null, "Input Must Be > 3 character and < 50 character");
    } else {
      _location = Validate(value, null);
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
  void changePhoneNum(String value) {
    if (value.length <= 3 || value.length > 12) {
      _phoneNum = Validate(null, "Input Must Be > 3 number and < 12 number");
    } else {
      _phoneNum = Validate(value, null);
    }
    notifyListeners();
  }

  Future getMyImage() async {
    var pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    notifyListeners();
  }

  void getUserInfo() {
    usName.text = _editModel.usName;
    _name = Validate(_editModel.usName,null);
    usAddress.text = _editModel.usAddress;
    _location = Validate(_editModel.usAddress,null);
    usPhone.text = _editModel.usPhoneNum;
    _phoneNum = Validate(_editModel.usPhoneNum,null);
    usDes.text = _editModel.usDes;
    _description = Validate(_editModel.usDes,null);
    usEmail.text = _editModel.usEmail;
    _email = Validate(_editModel.usEmail,null);
    usPass.text = _editModel.usPass;
    _pass = Validate(_editModel.usPass,null);
    _defaultImage = _editModel.usImage;
    notifyListeners();
  }

  void getActor() {

  }

  void editActor() {
    print(_name.value);
    print(_location.value);
    print(_phoneNum.value);
    print(_description.value);
  }

}