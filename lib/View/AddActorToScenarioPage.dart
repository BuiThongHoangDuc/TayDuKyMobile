import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobiletayduky/ViewModel/AddActorToScenarioVM.dart';
import 'package:scoped_model/scoped_model.dart';

class AddActorToScenarioPage extends StatelessWidget {
  final AddActorToScenarioVM addModel;

  AddActorToScenarioPage({this.addModel});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AddActorToScenarioVM>(
      model: addModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Actor For Scenario'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                addModel.addActortoScenario();
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ScopedModelDescendant<AddActorToScenarioVM>(
          builder: (context, child, addModel) {
//            if (addModel.isLoading == true)
//              return LoadingScreen();
//            else
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
                              _actorField(addModel),
                              _scenarioField(addModel)
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _roleInScenarioField(addModel),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 300),
                              child: TextField(
                                onChanged: (text) {
                                  addModel.changeComment(text);
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                    errorText: addModel.description.error,
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                        fontFamily: 'Arial',
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue))),
                              ),
                            ),
                          ),
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

Widget _actorField(AddActorToScenarioVM addModel) {
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
            addModel.nameActor,
            style: TextStyle(
                fontFamily: "Arial",
                color: Colors.grey,
                fontSize: 17,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
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
              value: addModel.selectedActor,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              onChanged: (String newValue) {
                addModel.changeSelectedActor(newValue);
              },
              items: addModel.emailUser
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      SizedBox(height: 10.0),
      Text(
        addModel.errorActor,
        style: TextStyle(fontFamily: "Arial", color: Colors.red),
      ),
    ],
  );
}

Widget _scenarioField(AddActorToScenarioVM addModel) {
  return Column(
    children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Scenario ",
          style: TextStyle(
              fontFamily: "Arial",
              color: Colors.blue,
              fontSize: 17,
              fontWeight: FontWeight.bold),
        ),
      ),
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
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
              hint: Text("Select Scenario"),
              value: addModel.selectedScenario,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              onChanged: (String newValue) {
                addModel.changeSelectedScenario(newValue);
              },
              items: addModel.scenarioName
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ),
      SizedBox(height: 10.0),
      Text(
        addModel.errorScenario,
        style: TextStyle(fontFamily: "Arial", color: Colors.red),
      ),
    ],
  );
}

Widget _roleInScenarioField(AddActorToScenarioVM addModel) {
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
            value: addModel.selectedScenario,
            icon: Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Colors.blue,
            ),
            onChanged: (String newValue) {
              addModel.changeSelectedScenario(newValue);
            },
            items: addModel.scenarioName
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
        addModel.errorScenario,
        style: TextStyle(fontFamily: "Arial", color: Colors.red),
      ),
    ],
  );
}
