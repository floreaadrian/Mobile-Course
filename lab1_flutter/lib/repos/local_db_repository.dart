import 'package:lab1_flutter/database_creator.dart';
import 'package:lab1_flutter/passanger.dart';
import 'package:lab1_flutter/repos/repository.dart';

class LocalDbRepository implements Repository {
  Future<List<Passanger>> getAll() async {
    final sql = '''SELECT * FROM ${DatabaseCreator.passangerTable}''';
    final data = await db.rawQuery(sql);
    List<Passanger> passangers = List();
    for (var node in data) {
      final passanger = Passanger.fromJson(node);
      passangers.add(passanger);
    }
    return passangers;
  }

  @override
  Future<void> add(Passanger passanger) async {
    final sql = '''INSERT INTO ${DatabaseCreator.passangerTable}
    (
      ${DatabaseCreator.name},
      ${DatabaseCreator.seatPosition},
      ${DatabaseCreator.airplaneName},
      ${DatabaseCreator.email}
    )
    VALUES
    (
      "${passanger.name}",
      "${passanger.seatPosition}",
      "${passanger.airplaneName}",
      "${passanger.email}"
    )
    ''';
    final result = await db.rawInsert(sql);
    DatabaseCreator.databaseLog('Add passanger', sql, null, result);
  }

  @override
  Future<void> delete(Passanger passanger) async {
    final sql = ''' DELETE FROM ${DatabaseCreator.passangerTable}
      WHERE ${DatabaseCreator.id} == ${passanger.id}
    ''';
    final result = await db.rawDelete(sql);
    DatabaseCreator.databaseLog('Delete passanger', sql, null, result);
  }

  @override
  Future<Passanger> findById(int id) async {
    final sql = '''SELECT * FROM ${DatabaseCreator.passangerTable}
      WHERE ${DatabaseCreator.id} == $id
    ''';
    final result = await db.rawQuery(sql);
    Passanger passanger = Passanger.fromJson(result[0].values.elementAt(0));

    DatabaseCreator.databaseLog('Find by id', sql, result, null);
    return passanger;
  }

  @override
  Future<void> update(Passanger oldPassanger, Passanger passanger) async {
    final sql = '''UPDATE ${DatabaseCreator.passangerTable}
    SET ${DatabaseCreator.airplaneName} = "${passanger.airplaneName}",
        ${DatabaseCreator.email} = "${passanger.email}",
        ${DatabaseCreator.name} = "${passanger.name}",
        ${DatabaseCreator.seatPosition} = "${passanger.seatPosition}"
    WHERE ${DatabaseCreator.id} == ${oldPassanger.id}
    ''';
    final result = await db.rawUpdate(sql);
    DatabaseCreator.databaseLog('Update passanger', sql, null, result);
  }
}
