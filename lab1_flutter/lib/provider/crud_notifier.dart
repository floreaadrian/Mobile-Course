import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab1_flutter/repos/repository.dart';

import '../controller.dart';
import '../passanger.dart';

class CrudNotifier extends ChangeNotifier {
  final Repository repository;
  final Controller controller;
  bool isOnline;

  CrudNotifier({
    @required this.repository,
    @required this.controller,
    this.isOnline,
  });

  Future<List<Passanger>> getPassangers() async {
    List<Passanger> passangers = await controller.getAll();
    return passangers;
  }

  void changeInternetStatus(bool userIsOnline) {
    isOnline = userIsOnline;
    notifyListeners();
  }

  void update(Passanger oldPasanger, Passanger passanger) {
    controller.update(oldPasanger, passanger).whenComplete(() {
      notifyListeners();
    });
  }

  void add(Passanger passanger) {
    controller.add(passanger).whenComplete(() {
      notifyListeners();
    });
  }

  void delete(Passanger passanger) {
    controller.delete(passanger).whenComplete(() {
      notifyListeners();
    });
  }
}
