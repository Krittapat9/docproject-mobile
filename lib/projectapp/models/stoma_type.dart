import 'package:json_annotation/json_annotation.dart';

part 'stoma_type.g.dart';

@JsonSerializable()
class StomaType {
  final int id;
  final String name;


  StomaType({
    required this.id,
    required this.name,});

  factory StomaType.fromJson(Map<String, dynamic> json) => _$StomaTypeFromJson(json);
}