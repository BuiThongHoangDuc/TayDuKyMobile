import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiletayduky/Model/ActorAddModel.dart';
import 'package:mobiletayduky/Repository/UserRepository.dart';
import 'package:mobiletayduky/View/EditActorPage.dart';
import 'package:mobiletayduky/View/LoginPage.dart';
import 'package:mobiletayduky/ViewModel/EditActorViewModel.dart';
import 'package:mobiletayduky/ViewModel/LoginViewModel.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerViewModel extends Model {
  String userName, userEmail, userImage;
  int usID;
  final IUserRepository _user = UserRepository();

  ActorAddModel actor;

  DrawerViewModel() {
    getSimpleInfo();
  }

  void getSimpleInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString("usName");
    usID = prefs.getInt("usId");
    userEmail = prefs.getString("usEmail");
    userImage = prefs.getString("usImage");
    notifyListeners();
  }

  void getInfo() async {
    actor = await _user.getActorByID(usID);
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setString("usName", actor.usName);
    pref.setInt("usId", actor.usID);
    pref.setString("usImage", actor.usImage);
    pref.setString("usEmail", actor.usEmail);
    getSimpleInfo();
  }

  void signOut(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(LoginViewModel()),
        ),
        (Route<dynamic> route) => false);
  }

  void getActorInfo(BuildContext context) async {
    ActorAddModel actor = await _user.getActorByID(usID);
    if (actor == null) {
      Fluttertoast.showToast(
        msg: "Is No Longer Available",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditActorPage(
            editModel: EditActorViewModel(actor),
          ),
        ),
      ).then((value) => getInfo());
    }
  }
}
