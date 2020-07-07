import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/ScenarioEditModel.dart';
import 'package:mobiletayduky/Repository/ScenarioRepository.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:path/path.dart' as path;

class EditScenarioViewModel extends Model {
  ScenarioEditModel _scenario;
  final IScenarioRepository scenarioRepo = new ScenarioRepository();

  EditScenarioViewModel(ScenarioEditModel scenario) {
    this._scenario = scenario;
    getScenarioInfo();
  }

  TextEditingController _nameControl = new TextEditingController();
  TextEditingController _locationControl = new TextEditingController();
  TextEditingController _castTimeControl = new TextEditingController();
  TextEditingController _desControl = new TextEditingController();

  TextEditingController get nameControl => _nameControl;

  TextEditingController get locationControl => _locationControl;

  TextEditingController get castTimeControl => _castTimeControl;

  TextEditingController get desControl => _desControl;

  File _image;
  File _script;

  File get script => _script;

  File get image => _image;
  String _defaultImage;
  String _fileScript;

  String get fileScript => _fileScript;

  String get defaultImage => _defaultImage;

  String _isHasScript = "Script hasn't been add yet";

  String get isHasScript => _isHasScript;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _selectedDateFromFormat;

  String get selectedDateFromFormat => _selectedDateFromFormat;

  DateTime _limitedDateTo;

  DateTime get limitedDateTo => _limitedDateTo;

  DateTime _selectedDateFrom = DateTime.now();

  DateTime get selectedDateFrom => _selectedDateFrom;

  DateTime _initDateFrom;

  DateTime get initDateFrom => _initDateFrom;

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

  void getScenarioInfo() {
    _nameControl.text = _scenario.scName;
    _name = Validate(_scenario.scName, null);
    _locationControl.text = _scenario.scLocation;
    _location = Validate(_scenario.scLocation, null);
    _castTimeControl.text = _scenario.scCastAmout.toString();
    _castTime = Validate(_scenario.scCastAmout.toString(), null);
    _desControl.text = _scenario.scDes;
    _description = Validate(_scenario.scDes, null);
    _defaultImage = _scenario.scImage;
    _selectedDateFromFormat =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(_scenario.scTimeFrom));
    _selectedDateToFormat =
        DateFormat('yyyy-MM-dd').format(DateTime.parse(_scenario.scTimeTo));
    if (DateTime.now().isAfter(DateTime.parse(_scenario.scTimeFrom))) {
      _selectedDateFrom = DateTime.now();
    } else
      _selectedDateFrom = DateTime.parse(_scenario.scTimeFrom);
    if (DateTime.now().isAfter(DateTime.parse(_scenario.scTimeTo))) {
      _selectedDateTo = DateTime.now();
    } else {
      _selectedDateTo = DateTime.parse(_scenario.scTimeTo);
      _limitedDateTo = _selectedDateTo;
    }
    _fileScript = _scenario.scScript;
    if (_scenario.scScript != null) _isHasScript = "Have a file Script";
    notifyListeners();
  }

  Future getScenario(int id) async {
    _scenario = await scenarioRepo.getScenariosByID(id);
    _isLoading = false;
    notifyListeners();
  }

  void editScenario() async {
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
      if (_script != null) {
        var urlScript = await upLoadFile();
        urlLink = urlScript.toString();
      } else
        urlLink = _fileScript;

      ScenarioEditModel editScenario = new ScenarioEditModel(
          scId: _scenario.scId,
          scName: name.value,
          scCastAmout: int.parse(castTime.value),
          scDes: description.value,
          scLocation: location.value,
          scImage: nowImage,
          scTimeFrom: _selectedDateFrom.toString(),
          scTimeTo: _selectedDateTo.toString(),
          scStatus: _scenario.scStatus,
          scScript: urlLink);

      String editScenarioJson = jsonEncode(editScenario.toJson());
      print(editScenarioJson);
      var status =
          await scenarioRepo.editScenario(_scenario.scId, editScenarioJson);
      if (status == "ERROR Database") {
        _isLoading = false;
        _name = Validate(null, "Name Is Already Exist");
        Fluttertoast.showToast(
          msg: "Edit Scenario Fail",
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
        await getScenario(status);
        Fluttertoast.showToast(
          msg: "Edit Scenario Success",
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
    var file = await FilePicker.getFile(
        allowedExtensions: ['txt', 'pdf', 'doc', 'docx'],
        type: FileType.custom);
    _script = File(file.path);
    _isHasScript = path.basename(_script.path);
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
