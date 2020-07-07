import 'package:flutter/material.dart';
import 'package:mobiletayduky/ViewModel/DrawerViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  final DrawerViewModel model;

  MyDrawer({this.model});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<DrawerViewModel>(
        model: model,
        child: ScopedModelDescendant<DrawerViewModel>(
          builder: (context, child, model) {
            return Drawer(
              child: new ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                      accountName: Text(model.userName),
                      accountEmail: Text(model.userEmail),
                      currentAccountPicture: new CircleAvatar(
                        backgroundColor: Colors.brown,
                        backgroundImage:
                        NetworkImage(model.userImage),
                      )),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Signout'),
                    onTap: () => model.signOut(context),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
