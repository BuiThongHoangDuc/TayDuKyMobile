import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/ViewModel/EditEquipmentViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class EditEqupimentPage extends StatelessWidget {

  final EditEquipmentViewModel editModel;

  EditEqupimentPage({this.editModel});

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
      leading: const Icon(Icons.build),
      title: new TextField(
        controller: editModel.nameControl,
        onChanged: (text) {
          editModel.changeName(text);
        },
        decoration: new InputDecoration(
          errorText: editModel.name.error,
          hintText: "Equipment Name",
        ),
      ),
    );
  }

  Widget _buildQuantityField() {
    return ListTile(
      leading: const Icon(Icons.plus_one),
      title: new TextField(
        controller: editModel.quantityControl,
        onChanged: (text) {
          editModel.changeQuantity(text);
        },
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          errorText: editModel.quantity.error,
          hintText: "Quantity",
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
                controller: editModel.desControl,
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
    return ScopedModel<EditEquipmentViewModel>(
      model: editModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Edit Equipment'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                editModel.editEquipment();
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
        body: ScopedModelDescendant<EditEquipmentViewModel>(
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
                          _buildQuantityField(),
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
