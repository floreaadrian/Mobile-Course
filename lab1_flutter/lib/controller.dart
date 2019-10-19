import 'package:lab1_flutter/passanger.dart';
import 'package:lab1_flutter/repository.dart';

class Controller {
  final Repository repository;

  Controller({this.repository});

  void add(Passanger passanger) {
    repository.add(passanger);
  }

  void delete(Passanger passanger) {
    repository.delete(passanger.id);
  }

  void update(Passanger oldPasanger, Passanger passanger) {
    repository.update(oldPasanger, passanger);
  }

  List<Passanger> getAll() {
    return repository.getAll;
  }
}
