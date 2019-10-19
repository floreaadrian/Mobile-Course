import 'dart:math';

import 'package:lab1_flutter/passanger.dart';

class Repository {
  final List<Passanger> passangers = [Passanger(id: 1, name: "ce")];

  void add(Passanger passanger) {
    if (passanger.id != null)
      passanger = Passanger(id: biggestId() + 1, name: passanger.name);
    passangers.add(passanger);
  }

  void delete(int id) {
    Passanger passanger = findById(id);
    passangers.remove(passanger);
  }

  void update(Passanger passanger) {
    delete(passanger.id);
    add(passanger);
  }

  Passanger findById(int id) {
    for (int i = 0; i < passangers.length; ++i)
      if (passangers[i].id == id) return passangers[i];
    return null;
  }

  int biggestId() {
    int biggest = -1;
    for (int i = 0; i < passangers.length; ++i)
      if (passangers[i].id > biggest) biggest = passangers[i].id;
    return biggest;
  }

  List<Passanger> get getAll => passangers;
}
