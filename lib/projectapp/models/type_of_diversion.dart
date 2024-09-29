import 'package:json_annotation/json_annotation.dart';

part 'type_of_diversion.g.dart';

@JsonSerializable()
class TypeOfDiversion {
  final int id;
  final String name;

  TypeOfDiversion({
    required this.id,
    required this.name});

  factory TypeOfDiversion.fromJson(Map<String, dynamic> json) => _$TypeOfDiversionFromJson(json);
}