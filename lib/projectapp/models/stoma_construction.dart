import 'package:json_annotation/json_annotation.dart';

part 'stoma_construction.g.dart';

@JsonSerializable()
class StomaConstruction {
  final int id;
  final String name;

  StomaConstruction({
    required this.id,
    required this.name});

  factory StomaConstruction.fromJson(Map<String, dynamic> json) => _$StomaConstructionFromJson(json);
}