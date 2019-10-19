import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lab1_flutter/passanger.dart';
import 'package:lab1_flutter/provider/crud_notifier.dart';
import 'package:provider/provider.dart';

import 'commons/displayDialog.dart';

class PassangerWidget extends StatelessWidget {
  final Passanger passanger;
  final TextEditingController _textFieldController = TextEditingController();

  PassangerWidget({Key key, this.passanger}) : super(key: key);

  void addPassanger(BuildContext context) {
    final provider = Provider.of<CrudNotifier>(context, listen: true);
    provider.add(Passanger(name: _textFieldController.value.text));
  }

  void deletePassanger(BuildContext context, Passanger passanger) {
    final provider = Provider.of<CrudNotifier>(context, listen: true);
    provider.delete(passanger);
  }

  void updatePassanger(BuildContext context, Passanger passanger) async {
    Map<String, String> inputData = await displayDialog(
      context: context,
      title: "Update a passanger",
      buttonText: "Update",
    );
    Passanger passangerUpdated =
        Passanger(id: passanger.id, name: inputData["name"]);
    final provider = Provider.of<CrudNotifier>(context, listen: true);
    provider.update(passanger, passangerUpdated);
  }

  @override
  Widget build(BuildContext context) {
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
          onTap: () => updatePassanger(context, passanger),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () => deletePassanger(context, passanger),
        ),
      ],
    );
  }
}
