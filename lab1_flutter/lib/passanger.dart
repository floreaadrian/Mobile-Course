import 'package:equatable/equatable.dart';

class Passanger extends Equatable {
  final int id;
  final String name;

  Passanger({this.id, this.name});

  @override
  List<Object> get props => [id, name];
}
