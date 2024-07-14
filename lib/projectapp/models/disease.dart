import 'package:json_annotation/json_annotation.dart';

part 'disease.g.dart';

@JsonSerializable()
class Disease {
  final int id;
  final String name;

  Disease({
    required this.id,
    required this.name});

  factory Disease.fromJson(Map<String, dynamic> json) => _$DiseaseFromJson(json);
}