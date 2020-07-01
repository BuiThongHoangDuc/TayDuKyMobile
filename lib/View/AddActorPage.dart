import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/ViewModel/AddActorViewModel.dart';
import 'package:mobiletayduky/ViewModel/AddScenarioViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class AddActorPage extends StatelessWidget {
  final name = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final des = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();

  final AddActorViewModel addModel;

  AddActorPage({this.addModel});

  Widget _imagePickField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
          child: CircleAvatar(
            radius: 100,
            backgroundColor: Color(0xff476cfb),
            child: ClipOval(
              child: SizedBox(
                width: 180,
                height: 180,
                child: (addModel.image != null)
                    ? Image.file(
                        addModel.image,
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        addModel.defaultImage,
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 170, 0, 0),
            child: IconButton(
              icon: Icon(
                Icons.camera_alt,
                size: 30,
              ),
              onPressed: () {
                addModel.getMyImage();
              },
            ),
          ),
        )
      ],
    );
  }

  Widget _buildNameField() {
    return ListTile(
      leading: const Icon(Icons.person),
      title: new TextField(
        controller: name,
        onChanged: (text) {
          addModel.changeName(text);
        },
        decoration: new InputDecoration(
          errorText: addModel.name.error,
          hintText: "Name",
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return ListTile(
      leading: const Icon(Icons.email),
      title: new TextField(
        controller: email,
        onChanged: (text) {
          addModel.changeEmail(text);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
          errorText: addModel.email.error,
          hintText: "Email",
        ),
      ),
    );
  }

  Widget _buildAddressField() {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: new Container(
        child: new ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 300.0,
          ),
          child: new Scrollbar(
            child: new SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: new TextField(
                controller: address,
                onChanged: (text) {
                  addModel.changeLocation(text);
                },
                maxLines: null,
                decoration: new InputDecoration(
                  errorText: addModel.location.error,
                  hintText: "Address",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPassField() {
    return ListTile(
      leading: const Icon(Icons.lock),
      title: new TextField(
        controller: pass,
        onChanged: (text) {
          addModel.changePass(text);
        },
        decoration: new InputDecoration(
          errorText: addModel.pass.error,
          hintText: "Password",
        ),
      ),
    );
  }

  Widget _buildPhoneNumField() {
    return ListTile(
      leading: const Icon(Icons.phone),
      title: new TextField(
        controller: phone,
        onChanged: (text) {
          addModel.changePhoneNum(text);
        },
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          errorText: addModel.phoneNum.error,
          hintText: "Phone Number",
        ),
      ),
    );
  }

  Widget _buildDesField() {
    return ListTile(
      leading: const Icon(Icons.comment),
      title: new Container(
        child: new ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 300.0,
          ),
          child: new Scrollbar(
            child: new SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: new TextField(
                controller: des,
                onChanged: (text) {
                  addModel.changeComment(text);
                },
                maxLines: null,
                decoration: new InputDecoration(
                  errorText: addModel.description.error,
                  hintText: "Description",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AddActorViewModel>(
      model: addModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Actor'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                addModel.addActor(context);
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Text(
                    'Add',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ScopedModelDescendant<AddActorViewModel>(
          builder: (context, child, addModel) {
            if (addModel.isLoading == true)
              return LoadingScreen();
            else
              return Builder(
                builder: (context) => Container(
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          _imagePickField(),
                          _buildNameField(),
                          _buildEmailField(),
                          _buildPassField(),
                          _buildAddressField(),
                          _buildPhoneNumField(),
                          _buildDesField(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
