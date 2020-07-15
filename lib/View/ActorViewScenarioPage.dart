import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobiletayduky/Model/Destination.dart';
import 'package:mobiletayduky/Model/DestinationUser.dart';
import 'package:mobiletayduky/View/DetailActorViewScenario.dart';
import 'package:mobiletayduky/View/DrawerBar.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/View/NotFoundScreen.dart';
import 'package:mobiletayduky/ViewModel/ActorViewScenarioVM.dart';
import 'package:mobiletayduky/ViewModel/DetailActorViewScenarioVM.dart';
import 'package:mobiletayduky/ViewModel/DrawerViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorViewScenarioPage extends StatelessWidget {
  final ActorViewScenarioVM avs;

  ActorViewScenarioPage({this.avs});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ActorViewScenarioVM>(
      model: avs,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Scenario"),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(Icons.person),
                onPressed: () => Scaffold.of(context).openDrawer(),
                color: Colors.white,
              );
            },
          ),
        ),
        drawer: MyDrawer(model: DrawerViewModel()),
        body: ScopedModelDescendant<ActorViewScenarioVM>(
          builder: (context, child, avs) {
            if (avs.isLoading == true) {
              return LoadingScreen();
            } else if (avs.isLoading == false && avs.isHave) {
              return NotFoundScreen();
            } else {
              return Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: getListScenario(context, avs),
              );
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          onTap: (index) {
            avs.onChangeBar(context, index);
          },
          items: allDestinationUser.map((DestinationUser destination) {
            return BottomNavigationBarItem(
              icon: Icon(destination.icon),
              title: Text(destination.title),
            );
          }).toList(),
          showUnselectedLabels: false,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.black45,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

getListScenario(BuildContext context, ActorViewScenarioVM avs) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: avs.scenarioList.length,
    itemBuilder: (context, index) {
      return _getScenarioUI(context, index, avs);
    },
    padding: EdgeInsets.all(0),
  );
}

Widget _getScenarioUI(
    BuildContext context, int index, ActorViewScenarioVM avs) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 5,
    child: InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailActorViewScenario(
                      davsVM: DetailActorViewScenarioVM(
                          avs.scenarioList[index].scID, avs.userID),
                    )));
      },
      child: Container(
        height: 172,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 172,
              width: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(avs.scenarioList[index].scImage),
                  )),
            ),
            Container(
              height: 172,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 2, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
//                  Text(index.toString()),
                    Container(
                      width: 260,
                      child: Text(avs.scenarioList[index].scName,
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.red)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                      child: Container(
                        width: 220,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.teal),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 70,
                              child: Text('Location:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              width: 140,
                              child: Text(
                                avs.scenarioList[index].scLocation,
//                                overflow: TextOverflow.ellipsis,
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
                                    avs.scenarioList[index].scTimeFrom)),
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
                                    avs.scenarioList[index].scTimeto)),
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
                            getStatus(
                                avs.scenarioList[index].scStatus,
                                avs.scenarioList[index].scTimeFrom,
                                avs.scenarioList[index].scTimeto),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: (avs.scenarioList[index].scScript != null)
                          ? Container(
                              child: RaisedButton(
                                onPressed: () {
                                  avs.launchURL(
                                      avs.scenarioList[index].scScript);
                                },
                                textColor: Colors.white,
                                padding: const EdgeInsets.all(0.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color(0xFF0D47A1),
                                        Color(0xFF1976D2),
                                        Color(0xFF42A5F5),
                                      ],
                                    ),
                                  ),
                                  padding: const EdgeInsets.all(10.0),
                                  child: const Text('Download Script',
                                      style: TextStyle(fontSize: 20)),
                                ),
                              ),
                            )
                          : Text(
                              'Does not add Script yet',
                              style: TextStyle(color: Colors.red),
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

Widget getStatus(int status, String dateFrom, String dateTo) {
  DateTime now =
      DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now()));
  DateTime dateFromFormat =
      DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(dateFrom)));
  DateTime dateToFormat =
      DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.parse(dateTo)));
  if (status == 2) {
    return Container(
      width: 160,
      child: Text(
        "Done",
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Colors.green),
      ),
    );
  } else {
    if (now.isAfter(dateFromFormat) && now.isAfter(dateToFormat)) {
      return Container(
        width: 160,
        child: Text(
          "Over Date",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.red),
        ),
      );
    } else if (now.isBefore(dateFromFormat)) {
      return Container(
        width: 160,
        child: Text(
          "Up Coming",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.green),
        ),
      );
    } else {
      return Container(
        width: 160,
        child: Text(
          "In Process",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.yellow),
        ),
      );
    }
  }
}
