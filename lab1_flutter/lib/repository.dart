import 'package:lab1_flutter/passanger.dart';

class Repository {
  final List<Passanger> passangers = [
    Passanger(
        id: 1,
        name: "ce",
        airplaneName: "clj->buc",
        seatPosition: "c3",
        email: "fds@fds.com")
  ];
  int biggestId = -1;

  Repository() {
    biggestId = findTheBiggestId();
  }

  void add(Passanger passanger) {
    if (passanger.id == null)
      passanger = Passanger(
          id: biggestId + 1,
          name: passanger.name,
          airplaneName: passanger.airplaneName,
          email: passanger.email,
          seatPosition: passanger.seatPosition);
    passangers.add(passanger);
    biggestId = findTheBiggestId();
  }

  void delete(int id) {
    Passanger passanger = findById(id);
    passangers.remove(passanger);
  }

  void update(Passanger oldPassanger, Passanger passanger) {
    int poisition = passangers.lastIndexOf(oldPassanger);
    delete(passanger.id);
    addAtPosition(passanger, poisition);
  }

  void addAtPosition(Passanger passanger, int position) {
    passangers.insert(position, passanger);
  }

  Passanger findById(int id) {
    for (int i = 0; i < passangers.length; ++i)
      if (passangers[i].id == id) return passangers[i];
    return null;
  }

  int findTheBiggestId() {
    int biggest = -1;
    for (int i = 0; i < passangers.length; ++i)
      if (passangers[i].id > biggest) biggest = passangers[i].id;
    return biggest;
  }

  List<Passanger> get getAll => passangers;
}
