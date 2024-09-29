import 'package:json_annotation/json_annotation.dart';

part 'stoma_shape.g.dart';

@JsonSerializable()
class StomaShape {
  final int id;
  final String name;

  StomaShape({
    required this.id,
    required this.name});

  factory StomaShape.fromJson(Map<String, dynamic> json) => _$StomaShapeFromJson(json);
}