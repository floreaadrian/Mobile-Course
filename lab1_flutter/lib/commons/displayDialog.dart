import 'package:flutter/material.dart';

Future<Map<String, String>> displayDialog(
    {BuildContext context, String title, String buttonText}) async {
  Map<String, String> inputData = {
    "name": "",
    "airplaneName": "",
    "seatPosition": "",
    "email": ""
  };
  return showDialog<Map<String, String>>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: TextField(
                  autofocus: true,
                  decoration: new InputDecoration(labelText: 'Name'),
                  onChanged: (value) {
                    inputData["name"] = value;
                  },
                ),
              ),
              TextField(
                decoration: new InputDecoration(
                    labelText: 'Email', hintText: "email@email.email"),
                onChanged: (value) {
                  inputData["email"] = value;
                },
              ),
              TextField(
                decoration: new InputDecoration(
                    labelText: 'Airplane Name', hintText: "CljBuc"),
                onChanged: (value) {
                  inputData["airplaneName"] = value;
                },
              ),
              TextField(
                decoration: new InputDecoration(
                    labelText: 'Seat Position', hintText: "C3"),
                onChanged: (value) {
                  inputData["seatPosition"] = value;
                },
              ),
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(buttonText),
              onPressed: () {
                print(inputData);
                Navigator.of(context).pop(inputData);
              },
            ),
            new FlatButton(
              child: new Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}
