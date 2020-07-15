import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/ActorAddModel.dart';
import 'package:mobiletayduky/Repository/UserRepository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class EditActorViewModel extends Model {
  final IUserRepository _userRepo = new UserRepository();

  String _updateBy, _timeUpdate;

  ActorAddModel _editModel;
  TextEditingController usName = TextEditingController();
  TextEditingController usAddress = TextEditingController();
  TextEditingController usPhone = TextEditingController();
  TextEditingController usDes = TextEditingController();
  TextEditingController usEmail = TextEditingController();
  TextEditingController usPass = TextEditingController();
  int _editModelRole;
  int get editModelRole => _editModelRole;
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

  void getUserInfo() async {
    usName.text = _editModel.usName;
    _name = Validate(_editModel.usName, null);
    usAddress.text = _editModel.usAddress;
    _location = Validate(_editModel.usAddress, null);
    usPhone.text = _editModel.usPhoneNum;
    _phoneNum = Validate(_editModel.usPhoneNum, null);
    usDes.text = _editModel.usDes;
    _description = Validate(_editModel.usDes, null);
    usEmail.text = _editModel.usEmail;
    _email = Validate(_editModel.usEmail, null);
    usPass.text = _editModel.usPass;
    _pass = Validate(_editModel.usPass, null);
    _defaultImage = _editModel.usImage;

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _updateBy = prefs.getString("usName");
    _timeUpdate = DateTime.now().toString();

    notifyListeners();
  }

  Future getActor(int id) async {
    _editModel = await _userRepo.getActorByID(id);
    _isLoading = false;
    notifyListeners();
  }

  void editActor() async {
    _isReady = true;
    if (_name.value == null) {
      changeName("");
      _isReady = false;
    }
    if (_location.value == null) {
      changeLocation("");
      _isReady = false;
    }
    if (_phoneNum.value == null) {
      changePhoneNum("");
      _isReady = false;
    }
    if (_description.value == null) {
      changeComment("");
      _isReady = false;
    }
    if (_email.value == null) {
      changeEmail("");
      _isReady = false;
    }
    if (_pass.value == null) {
      changePass("");
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

      ActorAddModel editActor = new ActorAddModel(
          usID: _editModel.usID,
          usName: _name.value,
          usPass: _pass.value,
          usEmail: _email.value,
          usPhoneNum: _phoneNum.value,
          usDes: _description.value,
          usAddress: _location.value,
          usImage: nowImage,
          updateBy: _updateBy,
          updateTime: _timeUpdate);

      String editActorJson = jsonEncode(editActor.toJson());
      print(editActorJson);
      var status = await _userRepo.editActor(_editModel.usID, editActorJson);
      if (status == "ERROR Database") {
        _isLoading = false;
        _name = Validate(null, "Name Is Already Exist");
        Fluttertoast.showToast(
          msg: "Edit Actor Fail",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
        notifyListeners();
      } else if (status == "Not Found") {
        Fluttertoast.showToast(
          msg: "Is No Longer Available",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
      } else {
        await getActor(status);
        Fluttertoast.showToast(
          msg: "Edit Actor Success",
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
