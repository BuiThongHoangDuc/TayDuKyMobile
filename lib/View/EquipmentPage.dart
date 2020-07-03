import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobiletayduky/Model/Destination.dart';
import 'package:mobiletayduky/View/AddEquipmentPage.dart';
import 'package:mobiletayduky/View/DrawerBar.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/View/NotFoundScreen.dart';
import 'package:mobiletayduky/ViewModel/AddEquipmentViewModel.dart';
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
        body: GestureDetector(
          child: Column(
            children: <Widget>[
              ScopedModelDescendant<EquipmentViewModel>(
                builder: (context, child, equipVM) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: equipVM.value,
                      onChanged: (value) {
                        equipVM.seacrhList(value);
                      },
                      decoration: InputDecoration(
                          labelText: "Search",
                          hintText: "Search Actor",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  );
                },
              ),
              ScopedModelDescendant<EquipmentViewModel>(
                builder: (context, child, equipVM) {
                  if (equipVM.isLoading == true) {
                    return Expanded(
                      child: LoadingScreen(),
                    );
                  } else if (equipVM.isLoading == false && equipVM.isHave) {
                    return Expanded(
                      child: NotFoundScreen(),
                    );
                  } else
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: getListEquipment(context, equipVM),
                      ),
                    );
                },
              ),
            ],
          ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddEqupimentPage(addModel: AddEquipmentViewModel(),)))
          },
          tooltip: 'Add Equipment',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

Widget getListEquipment(BuildContext context, EquipmentViewModel equipVM) {
  return ListView.builder(
    scrollDirection: Axis.vertical,
    itemCount: equipVM.equipmentList.length,
    itemBuilder: (context, index) {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.5,
        child: _getEquipmentUI(context, index, equipVM),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              equipVM.deleteEquipment(index);
            },
          ),
        ],
      );
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
        int id = equipVM.equipmentList[index].equipmentId;
        equipVM.getEquipmentInfo(context,id);
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
                        equipVM.equipmentList[index].equipmentImage),
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
                      child: Text(equipVM.equipmentList[index].equipmentName,
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
                                equipVM.equipmentList[index].equipmentQuantity
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
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 2),
                      child: Container(
                        width: 260,
                        child: Text(
                          equipVM.equipmentList[index].equipmentDes,
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
