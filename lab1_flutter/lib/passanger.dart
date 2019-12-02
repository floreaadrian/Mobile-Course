import 'package:equatable/equatable.dart';

import 'database_creator.dart';

class Passanger extends Equatable {
  final int id;
  final String serverId;
  final String name;
  final String airplaneName;
  final String seatPosition;
  final String email;

  Passanger({
    this.serverId,
    this.airplaneName,
    this.seatPosition,
    this.email,
    this.id,
    this.name,
  });

  @override
  List<Object> get props => [id, name];

  Passanger.fromJson(Map<String, dynamic> json)
      : name = json[DatabaseCreator.name],
        email = json[DatabaseCreator.email],
        id = json[DatabaseCreator.id],
        airplaneName = json[DatabaseCreator.airplaneName],
        seatPosition = json[DatabaseCreator.seatPosition],
        serverId = json[DatabaseCreator.serverId];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'airplaneName': airplaneName,
        'seatPosition': seatPosition,
        '_id': serverId,
      };
}
