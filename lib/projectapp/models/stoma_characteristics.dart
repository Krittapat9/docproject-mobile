import 'package:json_annotation/json_annotation.dart';

part 'stoma_characteristics.g.dart';

@JsonSerializable()
class StomaCharacteristics {
  final int id;
  final String name;

  StomaCharacteristics({
    required this.id,
    required this.name});

  factory StomaCharacteristics.fromJson(Map<String, dynamic> json) => _$StomaCharacteristicsFromJson(json);
}