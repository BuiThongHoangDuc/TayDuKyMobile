import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/ViewModel/AddEquipmentInScenarioVM.dart';
import 'package:scoped_model/scoped_model.dart';

class AddEquipmentInScenarioPage extends StatelessWidget {
  final AddEquipmentInScenarioVM eis;

  AddEquipmentInScenarioPage({this.eis});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AddEquipmentInScenarioVM>(
      model: eis,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Equipment For Scenario'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                eis.addEquipmentScenario(context);
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
        body: ScopedModelDescendant<AddEquipmentInScenarioVM>(
          builder: (context, child, eis) {
            if (eis.isLoading == true)
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
                          _equipmentField(eis),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxHeight: 300),
                              child: TextField(
                                onChanged: (text) {
                                  eis.changeQuantity(text);
                                },
                                maxLines: null,
                                decoration: InputDecoration(
                                    errorText: eis.quantity.error,
                                    labelText: 'Quantity',
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

Widget _equipmentField(AddEquipmentInScenarioVM eis) {
  return Column(
    children: <Widget>[
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Equipment",
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
          width: 200,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              hint: Text("Select Equipment"),
              value: eis.selectedEquipment,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: TextStyle(color: Colors.black),
              underline: Container(
                height: 2,
                color: Colors.blue,
              ),
              onChanged: (String newValue) {
              eis.changeSelectedEquipment(newValue);
              },
              items: eis.equipmentName
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
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          eis.errorEquipment,
          style: TextStyle(fontFamily: "Arial", color: Colors.red),
        ),
      ),
    ],
  );
}
