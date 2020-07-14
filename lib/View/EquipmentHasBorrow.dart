import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/View/NotFoundScreen.dart';
import 'package:mobiletayduky/ViewModel/EquipmentHasBorrowVM.dart';
import 'package:scoped_model/scoped_model.dart';

class EquipmentHasBorrow extends StatelessWidget {
  final EquipmentHasBorrowVM ehb;

  EquipmentHasBorrow({this.ehb});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<EquipmentHasBorrowVM>(
      model: ehb,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Equipemt Has Borrow"),
        ),
        body: GestureDetector(
          child: ScopedModelDescendant<EquipmentHasBorrowVM>(
            builder: (context, child, ehb) {
              if (ehb.isLoading == true) {
                return LoadingScreen();
              } else if (ehb.isLoading == false && ehb.isHave) {
                return NotFoundScreen();
              } else
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: getListEquipment(context, ehb),
                );
            },
          ),
        ),
      ),
    );
  }
}

Widget getListEquipment(BuildContext context, EquipmentHasBorrowVM ehb) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: ehb.listEquipmentInSc.length,
    itemBuilder: (context, index) {
      return _getEquipmentUI(context, index, ehb);
    },
    padding: EdgeInsets.all(0),
  );
}

Widget _getEquipmentUI(
    BuildContext context, int index, EquipmentHasBorrowVM ehb) {
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
        height: 188,
        child: Row(
          children: <Widget>[
            Container(
              height: 185,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                        ehb.listEquipmentInSc[index].equipmentImage),
                  )),
            ),
            Container(
              height: 185,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 260,
                      child: Text(ehb.listEquipmentInSc[index].equipmentName,
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
                                ehb.listEquipmentInSc[index].equipmentQuantity
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
                                    ehb.listEquipmentInSc[index].updateByDate)),
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
                              width: 100,
                              child: Text('ScenarioName:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            Container(
//                            color: Colors.yellow,
                              width: 150,
                              child: Text(
                                ehb.listEquipmentInSc[index].scenarioName,
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
                              child: Text('TimeFrom:',
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
                                    ehb.listEquipmentInSc[index]
                                        .scenarioTimeFrom)),
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
                              child: Text('TimeTo:',
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
                                    ehb.listEquipmentInSc[index]
                                        .scenarioTimeTo)),
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
                                ehb.listEquipmentInSc[index].personUpdate,
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
                              child: Text('Status:',
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
                                "hello",
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
