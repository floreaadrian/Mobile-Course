import 'package:lab1_flutter/passanger.dart';
import 'package:lab1_flutter/repos/repository.dart';

class Controller {
  final Repository repository;

  Controller({this.repository});

  Future<void> add(Passanger passanger) async {
    return repository.add(passanger);
  }

  Future<void> delete(Passanger passanger) async {
    return repository.deletePassanger(passanger);
  }

  Future<void> update(Passanger oldPasanger, Passanger passanger) async {
    return repository.update(oldPasanger, passanger);
  }

  Future<List<Passanger>> getAll() async {
    List<Passanger> passangers = await repository.getAll();
    passangers.forEach((f) => print(f.toJson()));
    return passangers;
  }
}
