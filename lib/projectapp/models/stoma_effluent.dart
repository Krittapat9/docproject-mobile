import 'package:json_annotation/json_annotation.dart';

part 'stoma_effluent.g.dart';

@JsonSerializable()
class StomaEffluent {
  final int id;
  final String name;

  StomaEffluent({
    required this.id,
    required this.name});

  factory StomaEffluent.fromJson(Map<String, dynamic> json) => _$StomaEffluentFromJson(json);
}