import 'package:lab1_flutter/passanger.dart';
import 'package:lab1_flutter/repos/repository.dart';

class InMemoryRepository implements Repository {
  final List<Passanger> passangers = [
    Passanger(
        id: 1,
        name: "ce",
        airplaneName: "clj->buc",
        seatPosition: "c3",
        email: "fds@fds.com")
  ];
  int biggestId = -1;

  @override
  Future<void> add(Passanger passanger) async {
    biggestId = await findTheBiggestId();
    if (passanger.id == null || passanger.id == -1)
      passanger = Passanger(
          id: biggestId + 1,
          name: passanger.name,
          airplaneName: passanger.airplaneName,
          email: passanger.email,
          seatPosition: passanger.seatPosition);
    passangers.add(passanger);
  }

  @override
  Future<void> delete(Passanger passanger) async {
    passangers.remove(passanger);
  }

  @override
  Future<void> update(Passanger oldPassanger, Passanger passanger) async {
    int poisition = passangers.lastIndexOf(oldPassanger);
    await delete(passanger);
    await addAtPosition(passanger, poisition);
  }

  Future<void> addAtPosition(Passanger passanger, int position) async {
    passangers.insert(position, passanger);
  }

  @override
  Future<Passanger> findById(int id) async {
    for (int i = 0; i < passangers.length; ++i)
      if (passangers[i].id == id) return passangers[i];
    return null;
  }

  Future<int> findTheBiggestId() async {
    int biggest = -1;
    for (int i = 0; i < passangers.length; ++i)
      if (passangers[i].id > biggest) biggest = passangers[i].id;
    return biggest;
  }

  @override
  Future<List<Passanger>> getAll() async {
    return passangers;
  }
}
