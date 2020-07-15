import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/View/NotFoundScreen.dart';
import 'package:mobiletayduky/ViewModel/DetailActorViewScenarioVM.dart';
import 'package:scoped_model/scoped_model.dart';

class DetailActorViewScenario extends StatelessWidget {
  final DetailActorViewScenarioVM davsVM;

  DetailActorViewScenario({this.davsVM});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<DetailActorViewScenarioVM>(
      model: davsVM,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Actor In Scenario"),
        ),
        body: GestureDetector(
          child: ScopedModelDescendant<DetailActorViewScenarioVM>(
            builder: (context, child, davsVM) {
              if (davsVM.isLoading == true) {
                return LoadingScreen();
              } else if (davsVM.isLoading == false && davsVM.isHave) {
                return NotFoundScreen();
              } else
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: getListAIC(context, davsVM),
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget getListAIC(BuildContext context, DetailActorViewScenarioVM davsVM) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: davsVM.listActorInSc.length,
    itemBuilder: (context, index) {
      return _getAICUI(context, index, davsVM);
    },
  );
}

Widget _getAICUI(BuildContext context, int index, DetailActorViewScenarioVM davsVM) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 5,
    child: InkWell(
      onTap: () {
//        int id = aicVM.listActorInSc[index].actorRoleId;
//        aicVM.getDetailInfo(context, id);
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
                Text(davsVM.listActorInSc[index].actorInScenario,
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
                        davsVM.listActorInSc[index].actorEmail,
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
                        davsVM.listActorInSc[index].roleScenarioId,
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
                        davsVM.listActorInSc[index].admin,
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
                            davsVM.listActorInSc[index].dateUpdate)),
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
