import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ScenarioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Scenario Page"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: getListScenario(context),
      ),
    );
  }
}

getListScenario(BuildContext context) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: 5,
    itemBuilder: _getScenarioUI,
    padding: EdgeInsets.all(0),
  );
}

Widget _getScenarioUI(BuildContext context, int index) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    elevation: 5,
    child: InkWell(
      onTap: () {
        print(index.toString());
      },
      child: Container(
        height: 172,
        child: Row(
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
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://firebasestorage.googleapis.com/v0/b/journey-to-the-west-3db0d.appspot.com/o/chapter3.jpeg?alt=media&token=43e1be21-7b9f-437d-b386-c7c0b3015362"),
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
                    Text('The Demon He Realizes',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.red)),
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
//                            color: Colors.red,
                              width: 70,
                              child: Text('Location:',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Container(
//                            color: Colors.yellow,
                              width: 140,
                              child: Text('Under the mountant'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                      child: Container(
                        width: 260,
                        child: Text(
                          'The Demon He Realizes Save Wukong To DeFeet him',
                          style: TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 48, 48, 54)),
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

//Widget _getScenarioUI(BuildContext context, int index) {
//  return Card(
//    color: Colors.red,
//    child: Column(
//      children: <Widget>[
//        ListTile(
//          dense: true,
//          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0.0),
//          leading: Image.network(
//            "https://firebasestorage.googleapis.com/v0/b/journey-to-the-west-3db0d.appspot.com/o/chapter3.jpeg?alt=media&token=43e1be21-7b9f-437d-b386-c7c0b3015362",
//            fit: BoxFit.fill,
////            height: 200,
//            width: 100,
//          ),
//          title: Container(
//            child: Text(
//              "The Demon He Realizes",
//              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
//            ),
//            padding: EdgeInsets.fromLTRB(0, 7, 0, 0),
//          ),
//          subtitle: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: <Widget>[
//              Container(
////                color: Colors.red,
//                child: Text(
//                  "Location: Under the mountant",
//                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
//                ),
//                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//              ),
//              Container(
////                color: Colors.blue,
//                child: Text(
//                  "Wukong join",
//                  style: TextStyle(
//                    fontSize: 11,
//                    fontWeight: FontWeight.normal,
//                  ),
//                ),
//                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//              ),
//            ],
//          ),
//        )
//      ],
//    ),
//  );
//}

//Widget _getScenarioUI(BuildContext context, int index) {
//  return Padding(
//    padding: const EdgeInsets.all(16),
//    child: Container(
//      child: FittedBox(
//        child: Material(
//          color: Colors.white,
//          elevation: 14,
//          borderRadius: BorderRadius.circular(24),
//          shadowColor: Color(0x802196F3),
//          child: InkWell(
//            onTap: () => print("Container pressed"),
//            child: Row(
//              children: <Widget>[
//                Container(
////                  color: Colors.red,
//                  child: myDetailContainer(),
//                ),
//                Container(
////                  color: Colors.blue,
//                  width: 250,
//                  height: 180,
//                  child: ClipRRect(
//                    borderRadius: BorderRadius.circular(24),
//                    child: Image(
//                      fit: BoxFit.contain,
//                      alignment: Alignment.topRight,
//                      image: NetworkImage(
//                          "https://firebasestorage.googleapis.com/v0/b/journey-to-the-west-3db0d.appspot.com/o/chapter1.jpg?alt=media&token=7c7b6d18-62e7-4085-9328-1283da896a68"),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    ),
//  );
//}
//
//Widget myDetailContainer() {
//  return Column(
//    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//    children: <Widget>[
//      Padding(
//        padding: const EdgeInsets.only(left: 8),
//        child: Container(
//          child: Text(
//            'The Demon He Realizes',
//            style: TextStyle(
//                color: Color(0xffe6020a),
//                fontSize: 24,
//                fontWeight: FontWeight.bold),
//          ),
//        ),
//      ),
//      Padding(
//        padding: const EdgeInsets.only(left: 8),
//        child: Container(
//          child: Row(
//            children: <Widget>[
//              Container(
//                child: Row(
//                  children: <Widget>[
//                    Text(
//                      'Location:',
//                      style: TextStyle(
//                          color: Colors.black54,
//                          fontSize: 18,
//                          fontWeight: FontWeight.bold),
//                    ),
//                    Text(
//                      'Under the mountant',
//                      style: TextStyle(color: Colors.black54, fontSize: 18),
//                    ),
//                  ],
//                ),
//              ),
//              Container(),
//            ],
//          ),
//        ),
//      )
//    ],
//  );
//}