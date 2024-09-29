import 'package:json_annotation/json_annotation.dart';

part 'peristomal_skin.g.dart';

@JsonSerializable()
class PeristomalSkin {
  final int id;
  final String name;

  PeristomalSkin({
    required this.id,
    required this.name});

  factory PeristomalSkin.fromJson(Map<String, dynamic> json) => _$PeristomalSkinFromJson(json);
}