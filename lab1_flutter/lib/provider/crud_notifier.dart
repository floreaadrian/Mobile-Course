import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../controller.dart';
import '../repository.dart';
import '../passanger.dart';

class CrudNotifier extends ChangeNotifier {
  final Repository repository;
  final Controller controller;

  CrudNotifier({@required this.repository, @required this.controller});

  List<Passanger> get getPassangers => controller.getAll();
  void update(Passanger oldPasanger, Passanger passanger) {
    controller.update(oldPasanger, passanger);
    notifyListeners();
  }

  void add(Passanger passanger) {
    controller.add(passanger);
    notifyListeners();
  }

  void delete(Passanger passanger) {
    controller.delete(passanger);
    notifyListeners();
  }
}
