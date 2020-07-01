import 'package:flutter/material.dart';
import 'package:mobiletayduky/View/LoadingScreen.dart';
import 'package:mobiletayduky/ViewModel/AddScenarioViewModel.dart';
import 'package:scoped_model/scoped_model.dart';

class AddScenarioPage extends StatelessWidget {
  final name = TextEditingController();
  final location = TextEditingController();
  final castTime = TextEditingController();
  final des = TextEditingController();

  final AddScenarioViewModel addModel;

  AddScenarioPage({this.addModel});

  Future<Null> _selectDateFrom(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: addModel.selectedDateFrom,
        firstDate: DateTime.now(),
        lastDate: addModel.limitedDateTo);
    if (picked != null && picked != addModel.selectedDateFrom) {
      addModel.selectedDateFrom = picked;
    }
  }

  Future<Null> _selectDateTo(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: addModel.selectedDateFrom,
        firstDate: addModel.selectedDateFrom,
        lastDate: DateTime(2101));
    if (picked != null && picked != addModel.selectedDateTo) {
      addModel.selectedDateTo = picked;
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
      leading: const Icon(Icons.movie_filter),
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

  Widget _buildLocationField() {
    return ListTile(
      leading: const Icon(Icons.location_on),
      title: new TextField(
        controller: location,
        onChanged: (text) {
          addModel.changeLocation(text);
        },
        decoration: new InputDecoration(
          errorText: addModel.location.error,
          hintText: "Location",
        ),
      ),
    );
  }

  Widget _buildCastTimeField() {
    return ListTile(
      leading: const Icon(Icons.movie_creation),
      title: new TextField(
        controller: castTime,
        onChanged: (text) {
          addModel.changeCastTime(text);
        },
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(
          errorText: addModel.castTime.error,
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
                  addModel.selectedDateFromFormat,
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
                  addModel.selectedDateToFormat,
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

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AddScenarioViewModel>(
      model: addModel,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Add Scenario'),
          actions: <Widget>[
            InkWell(
              onTap: () {
                addModel.addScenario(context);
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
        body: ScopedModelDescendant<AddScenarioViewModel>(
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
                          _buildLocationField(),
                          _buildCastTimeField(),
                          _buildDateFromField(context),
                          _buildDateToField(context),
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
