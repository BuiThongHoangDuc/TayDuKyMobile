import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/ActorAddModel.dart';
import 'package:mobiletayduky/Repository/UserRepository.dart';
import 'package:mobiletayduky/View/ActorPage.dart';
import 'package:mobiletayduky/ViewModel/ActorViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

class AddActorViewModel extends Model {
  final UserRepository _userRepo = new UserRepository();
  ActorAddModel _addModel;

  String _createBy, _updateBy, _timeUpdate;

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

  void addActor(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _createBy = prefs.getString("usName");
    _updateBy = prefs.getString("usName");
    _timeUpdate = DateTime.now().toString();

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

      _addModel = new ActorAddModel(
          usID: 0,
          usAddress: _location.value,
          usDes: _description.value,
          usEmail: _email.value,
          usImage: nowImage,
          usName: _name.value,
          usPass: _pass.value,
          usPhoneNum: _phoneNum.value,
          updateTime: _timeUpdate,
          updateBy: _updateBy,
          createBy: _createBy);

      String addUserioJson = jsonEncode(_addModel.toJson());
      String status = await _userRepo.addUser(addUserioJson);
      if (status == "BadRequest") {
        _isLoading = false;
        _email = Validate(null, "Email Is Already Exist");
        Fluttertoast.showToast(
          msg: "Add Actor Fail",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
        notifyListeners();
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ActorPage(
                actorVModel: ActorViewModel(),
              ),
            ),
            (Route<dynamic> route) => false);
        Fluttertoast.showToast(
          msg: "Add Actor Success",
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
