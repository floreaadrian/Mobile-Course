import 'package:flutter/material.dart';

Future<Map<String, String>> displayDialog(
    {BuildContext context, String title, String buttonText}) async {
  Map<String, String> inputData = {"name": ""};
  return showDialog<Map<String, String>>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  inputData["name"] = value;
                },
              ))
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(buttonText),
              onPressed: () {
                Navigator.of(context).pop(inputData);
              },
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
