import 'package:json_annotation/json_annotation.dart';

part 'surgery.g.dart';

@JsonSerializable()
class Surgery {
  final int id;
  final int patient_id;
  final int surgery_type_id;
  final String? surgery_type_note_other;
  final int disease_id;
  final String? disease_note_other;
  final DateTime? date_of_surgery;
  final int staff_id;
  final int case_id;
  final String disease_name;
  final String surgery_type_name;
  final String staff_firstname;
  final String staff_lastname;
  final int? stoma_id;
  final String? stoma_type_name;
  final String? stoma_type_note_other;
  final String username;

  factory Surgery.fromJson(Map<String, dynamic> json) =>
      _$SurgeryFromJson(json);

  Surgery(
      {required this.id,
      required this.patient_id,
      required this.surgery_type_id,
      required this.surgery_type_note_other,
      required this.disease_id,
      required this.disease_note_other,
      required this.date_of_surgery,
      required this.staff_id,
      required this.case_id,
      required this.disease_name,
      required this.surgery_type_name,
      required this.staff_firstname,
      required this.staff_lastname,
      required this.stoma_id,
      required this.stoma_type_name,
      required this.stoma_type_note_other,
      required this.username});
}
