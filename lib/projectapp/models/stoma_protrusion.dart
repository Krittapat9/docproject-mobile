import 'package:json_annotation/json_annotation.dart';

part 'stoma_protrusion.g.dart';

@JsonSerializable()
class StomaProtrusion {
  final int id;
  final String name;

  StomaProtrusion({
    required this.id,
    required this.name});

  factory StomaProtrusion.fromJson(Map<String, dynamic> json) => _$StomaProtrusionFromJson(json);
}