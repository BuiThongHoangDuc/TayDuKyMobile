import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/ScenarioAddModel.dart';
import 'package:mobiletayduky/Repository/ScenarioRepository.dart';
import 'package:mobiletayduky/View/ScenarioPage.dart';
import 'package:mobiletayduky/ViewModel/ScenarioViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AddScenarioViewModel extends Model {
  final ScenarioRepository scenarioRepo = new ScenarioRepository();
  ScenarioAddModel _addModel;
  File _image;
  File _script;

  File get script => _script;
  File get image => _image;

  String _defaultImage =
      'https://firebasestorage.googleapis.com/v0/b/journey-to-the-west-3db0d.appspot.com/o/noimage.jpg?alt=media&token=e1a3652f-3c98-4230-a6c9-e4e5b1fac69a';
  String _scriptString = "Select File";

  String get scriptString => _scriptString;
  String get defaultImage => _defaultImage;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _selectedDateFromFormat =
      DateFormat('yyyy-MM-dd').format(DateTime.now());

  String get selectedDateFromFormat => _selectedDateFromFormat;

  DateTime _limitedDateTo = DateTime(2101);

  DateTime get limitedDateTo => _limitedDateTo;

  DateTime _selectedDateFrom = DateTime.now();

  DateTime get selectedDateFrom => _selectedDateFrom;

  set selectedDateFrom(DateTime selectedDateFrom) {
    _selectedDateFrom = selectedDateFrom;
    if (_selectedDateToFormat == _selectedDateFromFormat) {
      _selectedDateToFormat =
          DateFormat('yyyy-MM-dd').format(_selectedDateFrom);
      _selectedDateTo = selectedDateFrom;
    }
    _selectedDateFromFormat =
        DateFormat('yyyy-MM-dd').format(_selectedDateFrom);
    notifyListeners();
  }

  String _selectedDateToFormat =
      DateFormat('yyyy-MM-dd').format(DateTime.now());

  String get selectedDateToFormat => _selectedDateToFormat;

  DateTime _selectedDateTo = DateTime.now();

  DateTime get selectedDateTo => _selectedDateTo;

  bool _isReady = true;

  set selectedDateTo(DateTime selectedDateFrom) {
    _selectedDateTo = selectedDateFrom;
    _limitedDateTo = selectedDateFrom;
    _selectedDateToFormat = DateFormat('yyyy-MM-dd').format(_selectedDateTo);
    notifyListeners();
  }

  //Valite ALL INPUT
  Validate _name = Validate(null, null);
  Validate _location = Validate(null, null);
  Validate _description = Validate(null, null);
  Validate _castTime = Validate(null, null);

  //Getters
  Validate get name => _name;

  Validate get location => _location;

  Validate get description => _description;

  Validate get castTime => _castTime;

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
  void changeLocation(String value) {
    if (value.length <= 3 || value.length > 15) {
      _location =
          Validate(null, "Input Must Be > 3 character and < 15 character");
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
  void changeCastTime(String value) {
    var regex = r'^\d+$';
    RegExp regExp = new RegExp(regex);
    if (!regExp.hasMatch(value)) {
      _castTime = Validate(null, "Input Must Be Integer");
    } else if (int.parse(value) > 999) {
      _castTime = Validate(null, "Input Must < 999");
    } else {
      _castTime = Validate(value, null);
    }
    notifyListeners();
  }

  Future getMyImage() async {
    var pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);
    _image = File(pickedFile.path);
    notifyListeners();
  }

  void addScenario(BuildContext context) async {
    _isReady = true;
    if (_name.value == null) {
      changeName("");
      _isReady = false;
    }
    if (_location.value == null) {
      changeLocation("");
      _isReady = false;
    }
    if (_castTime.value == null) {
      changeCastTime("");
      _isReady = false;
    }
    if (_description.value == null) {
      changeComment("");
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
      String urlLink;
      if(_script != null) {
        var urlScript = await upLoadFile();
        urlLink = urlScript.toString();
      }
      else urlLink = null;
      _addModel = new ScenarioAddModel(
          scId: 0,
          scName: name.value,
          scCastAmout: int.parse(castTime.value),
          scDes: description.value,
          scLocation: location.value,
          scImage: nowImage,
          scTimeFrom: _selectedDateFrom.toString(),
          scTimeTo: _selectedDateTo.toString(),
          scScript: urlLink);
      String addScenarioJson = jsonEncode(_addModel.toJson());
      String status = await scenarioRepo.addScenarios(addScenarioJson);
      if (status == "BadRequest") {
        _isLoading = false;
        _name = Validate(null, "Name Is Already Exist");
        Fluttertoast.showToast(
          msg: "Add Scenario Fail",
          textColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.white,
          gravity: ToastGravity.CENTER,
        );
        notifyListeners();
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => ScenarioPage(
                scenarioModel: ScenarioViewModel(),
              ),
            ),
            (Route<dynamic> route) => false);
        Fluttertoast.showToast(
          msg: "Add Scenario Success",
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

  Future getFile() async {
    var file = await FilePicker.getFile(allowedExtensions: ['txt', 'pdf', 'doc', 'docx'], type: FileType.custom);
    _script = File(file.path);
    _scriptString = path.basename(_script.path);
    notifyListeners();
  }

  Future<String> upLoadFile() async {
    String basename = path.basename(_script.path);
    StorageReference reference = FirebaseStorage.instance.ref().child(basename);
    StorageUploadTask uploadTask = reference.putFile(_script);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String url = await reference.getDownloadURL();
    return url;
  }

}
