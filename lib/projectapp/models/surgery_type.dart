import 'package:json_annotation/json_annotation.dart';

part 'surgery_type.g.dart';

@JsonSerializable()
class SurgeryType {
  final int id;
  final String name;

  SurgeryType({
    required this.id,
    required this.name
  });

  factory SurgeryType.fromJson(Map<String, dynamic> json) => _$SurgeryTypeFromJson(json);
}