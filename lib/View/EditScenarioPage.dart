import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobiletayduky/View/ListActorInScenarioPage.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/ViewModel/EditScenarioViewModel.dart';
import 'package:mobiletayduky/ViewModel/ListActorInScenarioVM.dart';
import 'package:scoped_model/scoped_model.dart';

class EditScenarioPage extends StatelessWidget {
  final EditScenarioViewModel editModel;

  EditScenarioPage({this.editModel});

  Future<Null> _selectDateFrom(BuildContext context) async {
    if (editModel.limitedDateTo == null) {
      Fluttertoast.showToast(
        msg: "Please Change Date To First",
        textColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.white,
        gravity: ToastGravity.CENTER,
      );
    } else {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: editModel.selectedDateFrom,
          firstDate: DateTime.now(),
          lastDate: editModel.limitedDateTo);
      if (picked != null && picked != editModel.selectedDateFrom) {
        editModel.selectedDateFrom = picked;
      }
    }
  }

  Future<Null> _selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: editModel.selectedDateTo,
        firstDate: editModel.selectedDateFrom,
        lastDate: DateTime(2101));
    if (picked != null && picked != editModel.selectedDateTo) {
      editModel.selectedDateTo = picked;
    }
  }

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
      leading: const Icon(Icons.movie_filter),
      title: new TextField(
        controller: editModel.nameControl,
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

  Widget _buildLocationField() {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: new TextField(
        controller: editModel.locationControl,
        onChanged: (text) {
          editModel.changeLocation(text);
        },
        decoration: new InputDecoration(
          errorText: editModel.location.error,
          hintText: "Location",
        ),
      ),
    );
  }

  Widget _buildCastTimeField() {
    return ListTile(
      leading: const Icon(Icons.movie_creation),
      title: new TextField(
        controller: editModel.castTimeControl,
        onChanged: (text) {
          editModel.changeCastTime(text);
        },
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          errorText: editModel.castTime.error,
          hintText: "Cast Time",
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

  Widget _buildDateFromField(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.calendar_today),
        title: new InputDecorator(
          decoration: InputDecoration(
            labelText: 'DateFrom',
          ),
          child: InkWell(
            onTap: () {
              _selectDateFrom(context);
            },
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  editModel.selectedDateFromFormat,
                ),
                new Icon(Icons.arrow_drop_down,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade700
                        : Colors.white70),
              ],
            ),
          ),
        ));
  }

  Widget _buildFileScript(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.attach_file),
        title: new InputDecorator(
          decoration: InputDecoration(
            labelText: 'Script Scenario',
          ),
          child: InkWell(
            onTap: () {
              editModel.getFile();
            },
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                    child: new Text(
                  editModel.isHasScript,
                )),
                new Icon(Icons.edit,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade700
                        : Colors.white70),
              ],
            ),
          ),
        ));
  }

  Widget _buildDateToField(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.calendar_today),
        title: new InputDecorator(
          decoration: InputDecoration(
            labelText: 'DateTo',
          ),
          child: InkWell(
            onTap: () {
              _selectDateTo(context);
            },
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Text(
                  editModel.selectedDateToFormat,
                ),
                new Icon(Icons.arrow_drop_down,
                    color: Theme.of(context).brightness == Brightness.light
                        ? Colors.grey.shade700
                        : Colors.white70),
              ],
            ),
          ),
        ));
  }

  Widget _buildBtnListActor(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ListActorInScenarioPage(aicVM: ListActorInScenarioVM(editModel.scenarioID),))).then((value) => editModel.getScenario(editModel.scenarioID));
      },
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
          width: 170,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
            ),
          ),
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Text('List Actor', style: TextStyle(fontSize: 20)),
          )),
    );
  }

  Widget _buildBtnListEquipment(BuildContext context) {
    return RaisedButton(
      onPressed: () {},
      textColor: Colors.white,
      padding: const EdgeInsets.all(0.0),
      child: Container(
        width: 170,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Color(0xFF0D47A1),
              Color(0xFF1976D2),
              Color(0xFF42A5F5),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Text('List Equipment', style: TextStyle(fontSize: 20)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<EditScenarioViewModel>(
      model: editModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Edit Scenario'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                editModel.editScenario();
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
        body: ScopedModelDescendant<EditScenarioViewModel>(
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
                          _buildLocationField(),
                          _buildCastTimeField(),
                          _buildDateFromField(context),
                          _buildDateToField(context),
                          _buildDesField(),
                          _buildFileScript(context),
                          SizedBox(height: 30),
                          Row(
                            children: <Widget>[
                              SizedBox(width: 20),
                              _buildBtnListActor(context),
                              SizedBox(width: 20),
                              _buildBtnListEquipment(context),
                            ],
                          ),
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
