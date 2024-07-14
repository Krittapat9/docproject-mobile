import 'package:json_annotation/json_annotation.dart';

part 'surgery.g.dart';

@JsonSerializable()
class Surgery {
  final int id;
  final int patient_id;
  final int surgery_type_id;
  final String surgery_type_note_other;
  final int disease_id;
  final String disease_note_id;
  final DateTime date_of_surgery;
  final int staff_id;

  Surgery(
      {required this.id,
      required this.patient_id,
      required this.surgery_type_id,
      required this.surgery_type_note_other,
      required this.disease_id,
      required this.disease_note_id,
      required this.date_of_surgery,
      required this.staff_id});

  factory Surgery.fromJson(Map<String, dynamic> json) => _$SurgeryFromJson(json);
}
