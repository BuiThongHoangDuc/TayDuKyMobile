import 'package:flutter/material.dart';
import 'package:mobiletayduky/Model/Destination.dart';
import 'package:mobiletayduky/View/DrawerBar.dart';
import 'package:mobiletayduky/ViewModel/DrawerViewModel.dart';
import 'package:mobiletayduky/ViewModel/EquipmentViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class EquipmentPage extends StatelessWidget {
  final EquipmentViewModel equipVM;

  EquipmentPage({this.equipVM});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<EquipmentViewModel>(
      model: equipVM,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Equipemt Page"),
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
        body: ScopedModelDescendant<EquipmentViewModel>(
          builder: (context, child, equipVM) {
//            if (scenarioModel.isLoading == true) {
//              return LoadingScreen();
//            } else
            return Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: getListEquipment(context, equipVM),
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: equipVM.currentIndex,
          onTap: (index) {
            equipVM.onChangeBar(context, index);
          },
          items: allDestination.map((Destination destination) {
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

Widget getListEquipment(BuildContext context, EquipmentViewModel equipVM) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: 5,
    itemBuilder: (context, index) {
      return _getEquipmentUI(context, index, equipVM);
    },
    padding: EdgeInsets.all(0),
  );
}

Widget _getEquipmentUI(
    BuildContext context, int index, EquipmentViewModel equipVM) {
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
                        'https://firebasestorage.googleapis.com/v0/b/journey-to-the-west-3db0d.appspot.com/o/equipment1.jpg?alt=media&token=1c1b715a-ae09-470a-bb7c-2b284a7bfdb7'),
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
                      child: Text('Magic Wooden Staff',
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
                                '150',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.green),
                              ),
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
                          'This is use to fuckup alot of people so use it good',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 12,
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
