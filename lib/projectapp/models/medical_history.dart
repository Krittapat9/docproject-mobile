import 'package:json_annotation/json_annotation.dart';

part 'medical_history.g.dart';

@JsonSerializable()
class MedicalHistory {
  final int id;
  final int staff_id;
  final String staff_firstname;
  final String staff_lastname;
  final int surgery_id;
  final DateTime datetime_of_medical;

  final int type_of_diversion_id;
  final String type_of_diversion_name;
  final String? type_of_diversion_note_other;

  final int stoma_construction_id;
  final String stoma_construction_name;

  final int stoma_color_id;
  final String stoma_color_name;

  final int stoma_size_width_mm;
  final int stoma_size_length_mm;

  final int stoma_characteristics_id;
  final String stoma_characteristics_name;
  final String? stoma_characteristics_note_other;

  final int stoma_shape_id;
  final String stoma_shape_name;

  final int peristomal_skin_id;
  final String peristomal_skin_name;

  final int mucocutaneous_suture_line_id;
  final String mucocutaneous_suture_line_name;
  final String? mucocutaneous_suture_line_note_other;

  final int stoma_effluent_id;
  final String stoma_effluent_name;

  final int appliances_id;
  final String appliances_name;

  final int medicine_id;
  final String medicine_name;

  //final DateTime crated_at;


  factory MedicalHistory.fromJson(Map<String, dynamic> json) =>
      _$MedicalHistoryFromJson(json);

  MedicalHistory({required this.id, required this.staff_id, required this.staff_firstname, required this.staff_lastname, required this.surgery_id, required this.datetime_of_medical, required this.type_of_diversion_id, required this.type_of_diversion_name, required this.type_of_diversion_note_other, required this.stoma_construction_id, required this.stoma_construction_name, required this.stoma_color_id, required this.stoma_color_name, required this.stoma_size_width_mm, required this.stoma_size_length_mm, required this.stoma_characteristics_id, required this.stoma_characteristics_name, required this.stoma_characteristics_note_other, required this.stoma_shape_id, required this.stoma_shape_name, required this.peristomal_skin_id, required this.peristomal_skin_name, required this.mucocutaneous_suture_line_id, required this.mucocutaneous_suture_line_name, required this.mucocutaneous_suture_line_note_other, required this.stoma_effluent_id, required this.stoma_effluent_name, required this.appliances_id, required this.appliances_name, required this.medicine_id, required this.medicine_name,});



}
