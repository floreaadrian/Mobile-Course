import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lab1_flutter/passanger.dart';

Future<Map<String, dynamic>> displayDialog({
  BuildContext context,
  String title,
  String buttonText,
  Passanger passanger,
}) async {
  final _textKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController(
    text: passanger != null ? passanger.name : "",
  );
  TextEditingController _emailController = TextEditingController(
    text: passanger != null ? passanger.email : "",
  );
  TextEditingController _airplaneController = TextEditingController(
    text: passanger != null ? passanger.airplaneName : "",
  );
  TextEditingController _seatController = TextEditingController(
    text: passanger != null ? passanger.seatPosition : "",
  );

  return showDialog<Map<String, dynamic>>(
      context: context,
      barrierDismissible:
          false, // dialog is dismissible with a tap on the barrier
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Form(
            key: _textKey,
            child: SingleChildScrollView(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: TextFormField(
                        autofocus: true,
                        controller: _nameController,
                        decoration: new InputDecoration(labelText: 'Name'),
                        textInputAction: Platform.isAndroid
                            ? TextInputAction.next
                            : TextInputAction.continueAction),
                  ),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: new InputDecoration(
                          labelText: 'Email', hintText: "email@email.email"),
                      controller: _emailController,
                      textInputAction: Platform.isAndroid
                          ? TextInputAction.next
                          : TextInputAction.continueAction),
                  TextFormField(
                      decoration: new InputDecoration(
                          labelText: 'Airplane Name', hintText: "CljBuc"),
                      controller: _airplaneController,
                      textInputAction: Platform.isAndroid
                          ? TextInputAction.next
                          : TextInputAction.continueAction),
                  TextFormField(
                    decoration: new InputDecoration(
                        labelText: 'Seat Position', hintText: "C3"),
                    controller: _seatController,
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(buttonText),
              onPressed: () {
                Map<String, dynamic> inputData = {
                  "name": _nameController.text,
                  "airplaneName": _airplaneController.text,
                  "seatPosition": _seatController.text,
                  "email": _emailController.text
                };
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
