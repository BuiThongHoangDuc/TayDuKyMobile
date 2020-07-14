import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:mobiletayduky/View/AddActorToScenarioPage.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/View/NotFoundScreen.dart';
import 'package:mobiletayduky/ViewModel/AddActorToScenarioVM.dart';
import 'package:mobiletayduky/ViewModel/DetailActorToScenarioVM.dart';
import 'package:mobiletayduky/ViewModel/ListActorInScenarioVM.dart';
import 'package:scoped_model/scoped_model.dart';

import 'DetailActorInScenarioPage.dart';

class ListActorInScenarioPage extends StatelessWidget {
  final ListActorInScenarioVM aicVM;

  ListActorInScenarioPage({this.aicVM});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ListActorInScenarioVM>(
      model: aicVM,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Actor In Scenario"),
        ),
        body: GestureDetector(
          child: ScopedModelDescendant<ListActorInScenarioVM>(
            builder: (context, child, aicVM) {
              if (aicVM.isLoading == true) {
                return LoadingScreen();
              } else if (aicVM.isLoading == false && aicVM.isHave) {
                return NotFoundScreen();
              } else
                return Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: getListAIC(context, aicVM),
                );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddActorToScenarioPage(
                  addModel: AddActorToScenarioVM(aicVM.scenarioID),
                ),
              ),
            ).then((value) => aicVM.getAll()),
          },
          tooltip: 'Add Actor In Scenario',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

Widget getListAIC(BuildContext context, ListActorInScenarioVM aicVM) {
  return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: aicVM.listActorInSc.length,
      itemBuilder: (context, index) {
        return Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.3,
          child: _getAICUI(context, index, aicVM),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                aicVM.deleteAIS(index);
              },
            ),
          ],
        );
        ;
      });
}

Widget _getAICUI(BuildContext context, int index, ListActorInScenarioVM aicVM) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 5,
    child: InkWell(
      onTap: () {
      int id = aicVM.listActorInSc[index].actorRoleId;
      aicVM.getDetailInfo(context,id);
      },
      child: Container(
        height: 180,
        child: Container(
          height: 150,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(aicVM.listActorInSc[index].actorInScenario,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                  child: Row(
                    children: <Widget>[
                      Text('Email: ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(
                        aicVM.listActorInSc[index].actorEmail,
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                  child: Row(
                    children: <Widget>[
                      Text('Role In Scenario: ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                      Text(
                        aicVM.listActorInSc[index].roleScenarioId,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                  child: Row(
                    children: <Widget>[
                      Text('Person Update: ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      Text(
                        aicVM.listActorInSc[index].admin,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd').format(DateTime.parse(
                            aicVM.listActorInSc[index].dateUpdate)),
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
