import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:lab1_flutter/commons/displayDialog.dart';
import 'package:lab1_flutter/passanger.dart';
import 'package:lab1_flutter/provider/crud_notifier.dart';
import 'package:provider/provider.dart';

class PassangerWidget extends StatelessWidget {
  final Passanger passanger;

  PassangerWidget({Key key, this.passanger}) : super(key: key);

  void deletePassanger(BuildContext context, Passanger passanger) {
    final provider = Provider.of<CrudNotifier>(context, listen: true);
    provider.delete(passanger);
  }

  void updatePassanger(BuildContext context, Passanger passanger) async {
    Map<String, dynamic> inputData = await displayDialog(
      context: context,
      title: "Update a passanger",
      buttonText: "Update",
      passanger: passanger,
    );
    if (inputData == null) return;
    if (inputData["name"] == '' && inputData["email"] == '') return;
    inputData['id'] = passanger.id;
    Passanger passangerUpdated = Passanger.fromJson(inputData);
    final provider = Provider.of<CrudNotifier>(context, listen: true);
    provider.update(passanger, passangerUpdated);
  }

  void showDefaultSnackbar(BuildContext context) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('No internet connection'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CrudNotifier>(context, listen: true);
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: PassangerDetails(passanger: passanger),
      ),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Update',
          color: provider.isOnline ? Colors.blue : Colors.grey,
          icon: Icons.update,
          onTap: () {
            if (provider.isOnline) {
              updatePassanger(context, passanger);
            } else {
              showDefaultSnackbar(context);
            }
          },
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: provider.isOnline ? Colors.red : Colors.grey,
          icon: Icons.delete,
          onTap: () {
            if (provider.isOnline) {
              deletePassanger(context, passanger);
            } else {
              showDefaultSnackbar(context);
            }
          },
        ),
      ],
    );
  }
}

class PassangerDetails extends StatelessWidget {
  final Passanger passanger;
  const PassangerDetails({Key key, @required this.passanger}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionTile(
        title: ListTile(
          leading: CircleAvatar(
            child: Text(passanger.name[0].toUpperCase()),
          ),
          title: Text(passanger.name),
        ),
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[Text("Email: "), Text(passanger.email)],
                ),
                Row(
                  children: <Widget>[
                    Text("Airplane Name: "),
                    Text(passanger.airplaneName)
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text("Seat Position: "),
                    Text(passanger.seatPosition)
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
