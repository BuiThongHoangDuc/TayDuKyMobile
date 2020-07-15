import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:mobiletayduky/View/EquipmentPage.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/View/NotFoundScreen.dart';
import 'package:mobiletayduky/ViewModel/AddEquipmentInScenarioVM.dart';
import 'package:mobiletayduky/ViewModel/EquipmentInScenarioListVM.dart';
import 'package:scoped_model/scoped_model.dart';

import 'AddEquipmentInScenarioPage.dart';

class EquipmentInScenarioListPage extends StatelessWidget {
  final EquipmentInScenarioListVM eic;

  EquipmentInScenarioListPage({this.eic});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<EquipmentInScenarioListVM>(
      model: eic,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("List Equipemt In Scenario"),
        ),
        body: GestureDetector(
          child: Column(
            children: <Widget>[
              ScopedModelDescendant<EquipmentInScenarioListVM>(
                builder: (context, child, eic) {
                  if (eic.isLoading == true) {
                    return Expanded(
                      child: LoadingScreen(),
                    );
                  } else if (eic.isLoading == false && eic.isHave) {
                    return Expanded(
                      child: NotFoundScreen(),
                    );
                  } else
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: getListEquipment(context, eic),
                      ),
                    );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddEquipmentInScenarioPage(
                          eis: AddEquipmentInScenarioVM(eic.scenarioID),
                        ))).then((value) => eic.getAll())
          },
          tooltip: 'Add Equipment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

Widget getListEquipment(BuildContext context, EquipmentInScenarioListVM etc) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: etc.listEquipmentInSc.length,
    itemBuilder: (context, index) {
      return _getEquipmentUI(context, index, etc);
    },
    padding: EdgeInsets.all(0),
  );
}

Widget _getEquipmentUI(
    BuildContext context, int index, EquipmentInScenarioListVM etc) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 5,
    child: InkWell(
      onTap: () {
//        int id = equipVM.equipmentList[index].equipmentId;
//        equipVM.getEquipmentInfo(context,id);
      },
      child: Container(
        height: 100,
        child: Row(
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        etc.listEquipmentInSc[index].equipmentImage),
                  )),
            ),
            Container(
              height: 172,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 260,
                      child: Text(etc.listEquipmentInSc[index].equipmentName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Container(
                        width: 105,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
//                            color: Colors.red,
                              width: 70,
                              child: Text('Quantity:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green)),
                            ),
                            Container(
//                            color: Colors.yellow,
                              width: 30,
                              child: Text(
                                etc.listEquipmentInSc[index].equipmentQuantity
                                    .toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Container(
                        width: 260,
                        child: Row(
                          children: <Widget>[
                            Container(
//                            color: Colors.red,
                              width: 100,
                              child: Text('PersonAdd:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            Container(
//                            color: Colors.yellow,
                              width: 160,
                              child: Text(
                                etc.listEquipmentInSc[index].personUpdate,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Container(
                        width: 260,
                        child: Row(
                          children: <Widget>[
                            Container(
//                            color: Colors.red,
                              width: 80,
                              child: Text('DateAdd:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            Container(
//                            color: Colors.yellow,
                              width: 160,
                              child: Text(
                                DateFormat('yyyy-MM-dd').format(DateTime.parse(
                                    etc.listEquipmentInSc[index].updateByDate)),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
