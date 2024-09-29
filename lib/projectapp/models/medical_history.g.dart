// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MedicalHistory _$MedicalHistoryFromJson(Map<String, dynamic> json) =>
    MedicalHistory(
      id: (json['id'] as num).toInt(),
      staff_id: (json['staff_id'] as num).toInt(),
      staff_firstname: json['staff_firstname'] as String,
      staff_lastname: json['staff_lastname'] as String,
      surgery_id: (json['surgery_id'] as num).toInt(),
      datetime_of_medical:
          DateTime.parse(json['datetime_of_medical'] as String),
      type_of_diversion_id: (json['type_of_diversion_id'] as num).toInt(),
      type_of_diversion_name: json['type_of_diversion_name'] as String,
      type_of_diversion_note_other:
          json['type_of_diversion_note_other'] as String?,
      stoma_construction_id: (json['stoma_construction_id'] as num).toInt(),
      stoma_construction_name: json['stoma_construction_name'] as String,
      stoma_color_id: (json['stoma_color_id'] as num).toInt(),
      stoma_color_name: json['stoma_color_name'] as String,
      stoma_size_width_mm: (json['stoma_size_width_mm'] as num).toInt(),
      stoma_size_length_mm: (json['stoma_size_length_mm'] as num).toInt(),
      stoma_characteristics_id:
          (json['stoma_characteristics_id'] as num).toInt(),
      stoma_characteristics_name: json['stoma_characteristics_name'] as String,
      stoma_characteristics_note_other:
          json['stoma_characteristics_note_other'] as String?,
      stoma_shape_id: (json['stoma_shape_id'] as num).toInt(),
      stoma_shape_name: json['stoma_shape_name'] as String,
      peristomal_skin_id: (json['peristomal_skin_id'] as num).toInt(),
      peristomal_skin_name: json['peristomal_skin_name'] as String,
      mucocutaneous_suture_line_id:
          (json['mucocutaneous_suture_line_id'] as num).toInt(),
      mucocutaneous_suture_line_name:
          json['mucocutaneous_suture_line_name'] as String,
      mucocutaneous_suture_line_note_other:
          json['mucocutaneous_suture_line_note_other'] as String?,
      stoma_effluent_id: (json['stoma_effluent_id'] as num).toInt(),
      stoma_effluent_name: json['stoma_effluent_name'] as String,
      appliances_id: (json['appliances_id'] as num).toInt(),
      appliances_name: json['appliances_name'] as String,
      medicine_id: (json['medicine_id'] as num).toInt(),
      medicine_name: json['medicine_name'] as String,
    );

Map<String, dynamic> _$MedicalHistoryToJson(MedicalHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'staff_id': instance.staff_id,
      'staff_firstname': instance.staff_firstname,
      'staff_lastname': instance.staff_lastname,
      'surgery_id': instance.surgery_id,
      'datetime_of_medical': instance.datetime_of_medical.toIso8601String(),
      'type_of_diversion_id': instance.type_of_diversion_id,
      'type_of_diversion_name': instance.type_of_diversion_name,
      'type_of_diversion_note_other': instance.type_of_diversion_note_other,
      'stoma_construction_id': instance.stoma_construction_id,
      'stoma_construction_name': instance.stoma_construction_name,
      'stoma_color_id': instance.stoma_color_id,
      'stoma_color_name': instance.stoma_color_name,
      'stoma_size_width_mm': instance.stoma_size_width_mm,
      'stoma_size_length_mm': instance.stoma_size_length_mm,
      'stoma_characteristics_id': instance.stoma_characteristics_id,
      'stoma_characteristics_name': instance.stoma_characteristics_name,
      'stoma_characteristics_note_other':
          instance.stoma_characteristics_note_other,
      'stoma_shape_id': instance.stoma_shape_id,
      'stoma_shape_name': instance.stoma_shape_name,
      'peristomal_skin_id': instance.peristomal_skin_id,
      'peristomal_skin_name': instance.peristomal_skin_name,
      'mucocutaneous_suture_line_id': instance.mucocutaneous_suture_line_id,
      'mucocutaneous_suture_line_name': instance.mucocutaneous_suture_line_name,
      'mucocutaneous_suture_line_note_other':
          instance.mucocutaneous_suture_line_note_other,
      'stoma_effluent_id': instance.stoma_effluent_id,
      'stoma_effluent_name': instance.stoma_effluent_name,
      'appliances_id': instance.appliances_id,
      'appliances_name': instance.appliances_name,
      'medicine_id': instance.medicine_id,
      'medicine_name': instance.medicine_name,
    };
