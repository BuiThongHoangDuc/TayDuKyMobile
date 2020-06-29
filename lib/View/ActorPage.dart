import 'package:flutter/material.dart';
import 'package:mobiletayduky/Model/Destination.dart';
import 'package:mobiletayduky/View/DrawerBar.dart';
import 'package:mobiletayduky/ViewModel/ActorViewModel.dart';
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
        body: _buildList(context, actorVModel),
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
      ),
    );
  }
}

Widget _buildList(BuildContext context, ActorViewModel actorVModel) {
  return ScopedModelDescendant<ActorViewModel>(
    builder: (context, child, actorVModel) {
      return ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text('Hoang Duc'),
              subtitle: Text('Hello it me'),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/journey-to-the-west-3db0d.appspot.com/o/person1.jpg?alt=media&token=b446452e-2358-4905-94e2-86f6108f49a3'),
              ));
        },
      );
    },
  );
}
