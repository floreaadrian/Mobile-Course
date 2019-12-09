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
  Future<Passanger> add(Passanger passanger) async {
    final sql = '''INSERT INTO ${DatabaseCreator.passangerTable}
    (
      ${DatabaseCreator.name},
      ${DatabaseCreator.seatPosition},
      ${DatabaseCreator.airplaneName},
      ${DatabaseCreator.email},
      ${DatabaseCreator.serverId}
    )
    VALUES
    (
      "${passanger.name}",
      "${passanger.seatPosition}",
      "${passanger.airplaneName}",
      "${passanger.email}",
      "${passanger.serverId}"
    )
    ''';
    final result = await db.rawInsert(sql);
    DatabaseCreator.databaseLog('Add passanger', sql, null, result);
    int lastId = await lastInsertedId();
    Passanger newOne = Passanger(
        airplaneName: passanger.airplaneName,
        id: lastId,
        seatPosition: passanger.seatPosition,
        name: passanger.name,
        email: passanger.email);
    return newOne;
  }

  Future<int> lastInsertedId() async {
    final sql = '''SELECT last_insert_rowid()''';
    final result = await db.rawQuery(sql);
    return result[0].values.elementAt(0);
  }

  @override
  Future<void> deletePassanger(Passanger passanger) async {
    final sql = ''' DELETE FROM ${DatabaseCreator.passangerTable}
      WHERE ${DatabaseCreator.id} == ${passanger.id}
    ''';
    final result = await db.rawDelete(sql);
    DatabaseCreator.databaseLog('Delete passanger', sql, null, result);
  }

  // @override
  // Future<Passanger> findById(int id) async {
  //   final sql = '''SELECT * FROM ${DatabaseCreator.passangerTable}
  //     WHERE ${DatabaseCreator.id} == $id
  //   ''';
  //   final result = await db.rawQuery(sql);
  //   Passanger passanger = Passanger.fromJson(result[0].values.elementAt(0));

  //   DatabaseCreator.databaseLog('Find by id', sql, result, null);
  //   return passanger;
  // }

  @override
  Future<void> update(Passanger oldPassanger, Passanger passanger) async {
    final sql = '''UPDATE ${DatabaseCreator.passangerTable}
    SET ${DatabaseCreator.airplaneName} = "${passanger.airplaneName}",
        ${DatabaseCreator.email} = "${passanger.email}",
        ${DatabaseCreator.name} = "${passanger.name}",
        ${DatabaseCreator.seatPosition} = "${passanger.seatPosition}",
        ${DatabaseCreator.serverId} = "${passanger.serverId}"
    WHERE ${DatabaseCreator.id} == ${oldPassanger.id}
    ''';
    final result = await db.rawUpdate(sql);
    DatabaseCreator.databaseLog('Update passanger', sql, null, result);
  }
}
