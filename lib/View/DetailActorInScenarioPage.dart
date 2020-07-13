import 'package:flutter/material.dart';
import 'package:mobiletayduky/ViewModel/DetailActorToScenarioVM.dart';
import 'package:scoped_model/scoped_model.dart';

import 'LoadingScreen.dart';

class DetailActorInScenarioPage extends StatelessWidget {
  final DetailActorToScenarioVM editModel;

  DetailActorInScenarioPage({this.editModel});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<DetailActorToScenarioVM>(
      model: editModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Edit Actor For Scenario'),
          actions: <Widget>[
            InkWell(
              onTap: () {
//                addModel.addActortoScenario(context);
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Text(
                    'Save',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ScopedModelDescendant<DetailActorToScenarioVM>(
          builder: (context, child, editModel) {
            if (editModel.isLoading == true)
              return LoadingScreen();
            else
              return Builder(
                builder: (context) => Container(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: SingleChildScrollView(
                      child: Container(
                        padding:
                            EdgeInsets.only(top: 30.0, left: 20.0, right: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                _actorField(editModel),
                                _roleInScenarioField(editModel),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _descriptionField(editModel),
                            SizedBox(
                              height: 20,
                            ),
                            _dateUpdateField(editModel),
                            SizedBox(
                              height: 20,
                            ),
                            _personUpdateField(editModel),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}

Widget _descriptionField(DetailActorToScenarioVM editModel) {
  return Container(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300),
      child: TextField(
        controller: editModel.descriptionControl,
        onChanged: (text) {
          editModel.changeComment(text);
        },
        maxLines: null,
        decoration: InputDecoration(
            errorText: editModel.description.error,
            labelText: 'Description',
            labelStyle: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                color: Colors.blue),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
      ),
    ),
  );
}

Widget _dateUpdateField(DetailActorToScenarioVM editModel) {
  return Container(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300),
      child: TextField(
        controller: editModel.latestDateControl,
        enabled: false,
        onChanged: (text) {
//                                    addModel.changeComment(text);
        },
        maxLines: null,
        decoration: InputDecoration(
            labelText: 'Latest Date Update',
            labelStyle: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                color: Colors.blue),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
      ),
    ),
  );
}

Widget _personUpdateField(DetailActorToScenarioVM editModel) {
  return Container(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 300),
      child: TextField(
        controller: editModel.personUpdateControl,
        enabled: false,
        onChanged: (text) {
//                                    addModel.changeComment(text);
        },
        maxLines: null,
        decoration: InputDecoration(
            labelText: 'Email Person Update',
            labelStyle: TextStyle(
                fontFamily: 'Arial',
                fontWeight: FontWeight.bold,
                color: Colors.blue),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue))),
      ),
    ),
  );
}

Widget _roleInScenarioField(DetailActorToScenarioVM editModel) {
  return Column(
    children: <Widget>[
      Text(
        "Role In Scenario ",
        style: TextStyle(
            fontFamily: "Arial",
            color: Colors.blue,
            fontSize: 17,
            fontWeight: FontWeight.bold),
      ),
      Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.blue,
              width: 3.0,
            ),
          ),
        ),
        width: 150,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            hint: Text("Select Role"),
            value: editModel.selectedRole,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String newValue) {
//              addModel.changeSelectedRole(newValue);
            },
            items: editModel.roleName
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
      SizedBox(height: 10.0),
      Text(
        editModel.errorRole,
        style: TextStyle(fontFamily: "Arial", color: Colors.red),
      ),
    ],
  );
}

Widget _actorField(DetailActorToScenarioVM editModel) {
  return Column(
    children: <Widget>[
      Row(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Actor: ",
              style: TextStyle(
                  fontFamily: "Arial",
                  color: Colors.blue,
                  fontSize: 17,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            editModel.nameActor,
            style: TextStyle(
                fontFamily: "Arial",
                color: Colors.grey,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.blue,
              width: 3.0,
            ),
          ),
        ),
        width: 150,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            hint: Text("Select Actor"),
            value: editModel.selectedActor,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String newValue) {
//              addModel.changeSelectedRole(newValue);
            },
            items: editModel.emailUser
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
      SizedBox(height: 10.0),
      Text(
        editModel.errorRole,
        style: TextStyle(fontFamily: "Arial", color: Colors.red),
      ),
    ],
  );
}
