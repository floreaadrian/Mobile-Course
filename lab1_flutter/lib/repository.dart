import 'package:lab1_flutter/passanger.dart';

abstract class Repository {
  Future<void> add(Passanger passanger);
  Future<void> delete(int id);
  Future<void> update(Passanger oldPassanger, Passanger passanger);
  Future<Passanger> findById(int id);
  Future<List<Passanger>> getAll();
}
