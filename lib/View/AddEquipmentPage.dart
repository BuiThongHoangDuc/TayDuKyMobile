import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/ViewModel/AddEquipmentViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class AddEqupimentPage extends StatelessWidget {
  final name = TextEditingController();
  final quantity = TextEditingController();
  final des = TextEditingController();

  final AddEquipmentViewModel addModel;

  AddEqupimentPage({this.addModel});

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
      leading: const Icon(Icons.build),
      title: new TextField(
        controller: name,
        onChanged: (text) {
          addModel.changeName(text);
        },
        decoration: new InputDecoration(
          errorText: addModel.name.error,
          hintText: "Equipment Name",
        ),
      ),
    );
  }

  Widget _buildQuantityField() {
    return ListTile(
      leading: const Icon(Icons.plus_one),
      title: new TextField(
        controller: quantity,
        onChanged: (text) {
          addModel.changeQuantity(text);
        },
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          errorText: addModel.quantity.error,
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
    return ScopedModel<AddEquipmentViewModel>(
      model: addModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Equipment'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                addModel.addEquipment(context);
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
        body: ScopedModelDescendant<AddEquipmentViewModel>(
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
