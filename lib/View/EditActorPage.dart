import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/ViewModel/AddActorViewModel.dart';
import 'package:mobiletayduky/ViewModel/AddScenarioViewModel.dart';
import 'package:mobiletayduky/ViewModel/EditActorViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class EditActorPage extends StatelessWidget {
  final EditActorViewModel editModel;

  EditActorPage({this.editModel});

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
                child: (editModel.image != null)
                    ? Image.file(
                  editModel.image,
                  fit: BoxFit.fill,
                )
                    : Image.network(
                  editModel.defaultImage,
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
                editModel.getMyImage();
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
        controller: editModel.usName,
        onChanged: (text) {
          editModel.changeName(text);
        },
        decoration: new InputDecoration(
          errorText: editModel.name.error,
          hintText: "Name",
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return ListTile(
      leading: const Icon(Icons.email),
      title: new TextField(
        controller: editModel.usEmail,
        onChanged: (text) {
          editModel.changeEmail(text);
        },
        keyboardType: TextInputType.emailAddress,
        decoration: new InputDecoration(
          errorText: editModel.email.error,
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
                controller: editModel.usAddress,
                onChanged: (text) {
                  editModel.changeLocation(text);
                },
                maxLines: null,
                decoration: new InputDecoration(
                  errorText: editModel.location.error,
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
        controller: editModel.usPass,
        onChanged: (text) {
          editModel.changePass(text);
        },
        decoration: new InputDecoration(
          errorText: editModel.pass.error,
          hintText: "Password",
        ),
      ),
    );
  }

  Widget _buildPhoneNumField() {
    return ListTile(
      leading: const Icon(Icons.phone),
      title: new TextField(
        controller: editModel.usPhone,
        onChanged: (text) {
          editModel.changePhoneNum(text);
        },
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          errorText: editModel.phoneNum.error,
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
                controller: editModel.usDes,
                onChanged: (text) {
                  editModel.changeComment(text);
                },
                maxLines: null,
                decoration: new InputDecoration(
                  errorText: editModel.description.error,
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
    return ScopedModel<EditActorViewModel>(
      model: editModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Detail Info'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                editModel.editActor();
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child: Text(
                    'Save',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ScopedModelDescendant<EditActorViewModel>(
          builder: (context, child, editModel) {
            if (editModel.isLoading == true)
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
