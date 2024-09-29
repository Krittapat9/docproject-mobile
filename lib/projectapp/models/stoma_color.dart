import 'package:json_annotation/json_annotation.dart';

part 'stoma_color.g.dart';

@JsonSerializable()
class StomaColor {
  final int id;
  final String name;

  StomaColor({
    required this.id,
    required this.name});

  factory StomaColor.fromJson(Map<String, dynamic> json) => _$StomaColorFromJson(json);
}