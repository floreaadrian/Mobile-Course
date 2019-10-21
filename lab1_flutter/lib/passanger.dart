import 'package:equatable/equatable.dart';

class Passanger extends Equatable {
  final int id;
  final String name;
  final String airplaneName;
  final String seatPosition;
  final String email;

  Passanger(
      {this.airplaneName, this.seatPosition, this.email, this.id, this.name});

  @override
  List<Object> get props => [id, name];

  Passanger.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        email = json['email'] ?? '',
        id = int.parse(json['id'] ?? '-1') ?? -1,
        airplaneName = json['airplaneName'] ?? '',
        seatPosition = json['seatPosition'] ?? '';

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'airplaneName': airplaneName,
        'seatPosition': seatPosition
      };
}
