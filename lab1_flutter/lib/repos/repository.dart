import 'package:lab1_flutter/passanger.dart';

abstract class Repository {
  Future<Passanger> add(Passanger passanger);
  Future<void> deletePassanger(Passanger passanger);
  Future<void> update(Passanger oldPassanger, Passanger passanger);
  // Future<Passanger> findById(int id);
  Future<List<Passanger>> getAll();
}
