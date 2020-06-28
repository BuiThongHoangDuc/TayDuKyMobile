import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/ActorPage.dart';
import 'package:mobiletayduky/View/DrawerBar.dart';
import 'package:mobiletayduky/View/EquipmentPage.dart';
import 'file:///D:/Flutter/mobile_tayduky/lib/Model/Destination.dart';
import 'package:mobiletayduky/View/ScenarioPage.dart';
import 'package:mobiletayduky/ViewModel/DrawerViewModel.dart';
import 'package:mobiletayduky/ViewModel/HomeViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class HomePage extends StatelessWidget {
  final HomeViewModel homeModel;

  HomePage({this.homeModel});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<HomeViewModel>(
        model: homeModel,
        child: ScopedModelDescendant<HomeViewModel>(
          builder: (context, child, homeModel) {
            return Scaffold(
              drawer: MyDrawer(model: DrawerViewModel()),
              body: Builder(builder: (context) {
                return Stack(
                  children: <Widget>[
                    ActorPage(),
                    PageView(
                      controller: homeModel.pageController,
                      children: homeModel.screen,
                      onPageChanged: homeModel.onPageChange,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                    Positioned(
                      left: 4,
                      top: 28,
                      child: IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              }),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: homeModel.currentIndex,
                onTap: homeModel.onChangeBar,
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
            );
          },
        ));
  }
}
