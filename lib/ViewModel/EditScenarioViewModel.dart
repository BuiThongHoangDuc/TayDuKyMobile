import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobiletayduky/Helper/Validate.dart';
import 'package:mobiletayduky/Model/ScenarioEditModel.dart';
import 'package:scoped_model/scoped_model.dart';

class EditScenarioViewModel extends Model {
  ScenarioEditModel _scenario;
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

  File get image => _image;
  String _defaultImage;

  String get defaultImage => _defaultImage;

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
    _name = Validate(_scenario.scName,null);
    _locationControl.text = _scenario.scLocation;
    _location = Validate(_scenario.scLocation,null);
    _castTimeControl.text = _scenario.scCastAmout.toString();
    _castTime = Validate(_scenario.scCastAmout.toString(),null);
    _desControl.text = _scenario.scDes;
    _description = Validate(_scenario.scDes,null);
    _defaultImage = _scenario.scImage;
    _selectedDateFromFormat = DateFormat('yyyy-MM-dd').format(DateTime.parse(_scenario.scTimeFrom));
    _selectedDateToFormat = DateFormat('yyyy-MM-dd').format(DateTime.parse(_scenario.scTimeTo));
    if(DateTime.now().isAfter(DateTime.parse(_scenario.scTimeFrom))) {
      _selectedDateFrom = DateTime.now();
    }
    else _selectedDateFrom = DateTime.parse(_scenario.scTimeFrom);
    if(DateTime.now().isAfter(DateTime.parse(_scenario.scTimeTo))) {
      _selectedDateTo = DateTime.now();
    }
    else {
      _selectedDateTo = DateTime.parse(_scenario.scTimeTo);
      _limitedDateTo = _selectedDateTo;
    }
    notifyListeners();
  }

  void getScenario() {

  }

  void editScenario() {
    print(_name.value);
    print(_location.value);
    print(_castTime.value);
    print(_description.value);
  }
}