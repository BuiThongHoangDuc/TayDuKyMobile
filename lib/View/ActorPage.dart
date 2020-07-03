import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mobiletayduky/Model/Destination.dart';
import 'package:mobiletayduky/View/AddActorPage.dart';
import 'package:mobiletayduky/View/DrawerBar.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/View/NotFoundScreen.dart';
import 'package:mobiletayduky/ViewModel/ActorViewModel.dart';
import 'package:mobiletayduky/ViewModel/AddActorViewModel.dart';
import 'package:mobiletayduky/ViewModel/DrawerViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class ActorPage extends StatelessWidget {
  final ActorViewModel actorVModel;

  ActorPage({this.actorVModel});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ActorViewModel>(
      model: actorVModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Actor Page"),
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
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: <Widget>[
              ScopedModelDescendant<ActorViewModel>(
                  builder: (context, child, actorVModel) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: actorVModel.value,
                    onChanged: (value) {
                      actorVModel.seacrhList(value);
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
              }),
              ScopedModelDescendant<ActorViewModel>(
                builder: (context, child, actorVModel) {
                  if (actorVModel.isLoading == true) {
                    return Expanded(
                      child: LoadingScreen(),
                    );
                  } else if (actorVModel.isLoading == false &&
                      actorVModel.isHave) {
                    return Expanded(
                      child: NotFoundScreen(),
                    );
                  } else
                    return Expanded(
                      child: _buildList(context, actorVModel),
                    );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: actorVModel.currentIndex,
          onTap: (index) {
            actorVModel.onChangeBar(context, index);
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddActorPage(
                          addModel: AddActorViewModel(),
                        )))
          },
          tooltip: 'Add Actor',
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

Widget _buildList(BuildContext context, ActorViewModel actorVModel) {
  return ListView.builder(
    itemCount: actorVModel.userList.length,
    itemBuilder: (context, index) {
      return Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.5,
        child: InkWell(
            onTap: () {
              int id = actorVModel.userList[index].userId;
              actorVModel.getActorInfo(context, id);
              },
            child: ListTile(
                title: Text(actorVModel.userList[index].userName),
                subtitle: Text(actorVModel.userList[index].userEmail),
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(actorVModel.userList[index].userImage),
                ))),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () {
              actorVModel.deleteScenario(index);
            },
          ),
        ],
      );
    },
  );
}
