import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lab1_flutter/passanger.dart';
import 'package:lab1_flutter/repository.dart';

import 'controller.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Repository repository = new Repository();
    Controller controller = new Controller(repository: repository);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        controller: controller,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final Controller controller;

  const MyHomePage({this.title, this.controller, Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Passanger> passangers;
  TextEditingController _textFieldController = TextEditingController();
  int biggestId = 0;

  @override
  void initState() {
    super.initState();
    updateUi();
  }

  void addPassanger() {
    widget.controller.add(Passanger(name: _textFieldController.value.text));
    Navigator.of(context).pop();
    updateUi();
  }

  void deletePassanger(Passanger passanger) {
    widget.controller.delete(passanger);
    updateUi();
  }

  void updatePassanger(Passanger passanger) {
    _displayDialog(context,
        title: "Update a passanger",
        buttonText: "Update",
        onPress: addPassanger);
    Passanger passangerUpdated =
        Passanger(id: passanger.id, name: _textFieldController.value.text);
    widget.controller.update(passangerUpdated);
    Navigator.of(context).pop();
    updateUi();
  }

  updateUi() {
    setState(() {
      passangers = widget.controller.getAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> passangerWidgets =
        passangers.map((f) => passangerWidget(f)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          child: Column(
        children: passangerWidgets,
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: () => _displayDialog(context,
            title: "Add a passanger", buttonText: "ADD", onPress: addPassanger),
      ),
    );
  }

  Widget passangerWidget(Passanger passanger) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.indigoAccent,
            child: Text(passanger.id.toString()),
            foregroundColor: Colors.white,
          ),
          title: Text(passanger.name),
        ),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Update',
          color: Colors.blue,
          icon: Icons.update,
          onTap: () => updatePassanger(passanger),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => deletePassanger(passanger),
        ),
      ],
    );
  }

  _displayDialog(BuildContext context,
      {String title, String buttonText, Function onPress}) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: 'Name'),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(buttonText),
                onPressed: onPress,
              ),
              new FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}
