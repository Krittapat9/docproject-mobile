import 'package:json_annotation/json_annotation.dart';

part 'stoma.g.dart';

@JsonSerializable()
class Stoma {
  final int id;
  final int surgery_id;
  final int surgery_type_id;
  final String stoma_type_note_other;


  Stoma({required this.id,
    required this.surgery_id,
    required this.surgery_type_id,
    required this.stoma_type_note_other});

  factory Stoma.fromJson(Map<String, dynamic> json) => _$StomaFromJson(json);
}

