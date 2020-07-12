import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/View/NotFoundScreen.dart';
import 'package:mobiletayduky/ViewModel/ListActorInScenarioVM.dart';
import 'package:scoped_model/scoped_model.dart';

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
//              if (equipVM.isLoading == true) {
//                return Expanded(
//                  child: LoadingScreen(),
//                );
//              } else if (equipVM.isLoading == false && equipVM.isHave) {
//                return Expanded(
//                  child: NotFoundScreen(),
//                );
//              } else

              return Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: getListAIC(context, aicVM),
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
//            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEqupimentPage(addModel: AddEquipmentViewModel(),)))
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
      itemCount: 5,
      itemBuilder: (context, index) {
        return _getAICUI(context, index, aicVM);
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
//        int id = equipVM.equipmentList[index].equipmentId;
//        equipVM.getEquipmentInfo(context, id);
      },
      child: Container(
        height: 170,
        child: Container(
          height: 150,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                    "Hello Fucker",
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
                        "Wu Kong aslkjdlkas qoiwuejoi aslkjdlkc",
                        style: TextStyle(color: Colors.black,fontSize: 15),
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
                        "Wu Kong aslkjdlkas qoiwuejoi aslkjdlkc",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                  child: Container(
                    child: Text(
                      "Some Thing To Do",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 13, color: Color.fromARGB(255, 48, 48, 54)),
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
}
