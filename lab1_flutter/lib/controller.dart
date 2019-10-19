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

  void update(Passanger passanger) {
    repository.update(passanger);
  }

  List<Passanger> getAll() {
    return repository.getAll;
  }
}
