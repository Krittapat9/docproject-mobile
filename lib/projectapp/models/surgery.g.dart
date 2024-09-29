// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surgery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Surgery _$SurgeryFromJson(Map<String, dynamic> json) => Surgery(
      id: (json['id'] as num).toInt(),
      patient_id: (json['patient_id'] as num).toInt(),
      surgery_type_id: (json['surgery_type_id'] as num).toInt(),
      surgery_type_note_other: json['surgery_type_note_other'] as String?,
      disease_id: (json['disease_id'] as num).toInt(),
      disease_note_other: json['disease_note_other'] as String?,
      date_of_surgery: DateTime.parse(json['date_of_surgery'] as String),
      staff_id: (json['staff_id'] as num).toInt(),
      case_id: (json['case_id'] as num).toInt(),
      disease_name: json['disease_name'] as String,
      surgery_type_name: json['surgery_type_name'] as String,
      staff_firstname: json['staff_firstname'] as String,
      staff_lastname: json['staff_lastname'] as String,
      stoma_id: (json['stoma_id'] as num?)?.toInt(),
      stoma_type_name: json['stoma_type_name'] as String?,
      stoma_type_note_other: json['stoma_type_note_other'] as String?,
      username: json['username'] as String,
    );

Map<String, dynamic> _$SurgeryToJson(Surgery instance) => <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patient_id,
      'surgery_type_id': instance.surgery_type_id,
      'surgery_type_note_other': instance.surgery_type_note_other,
      'disease_id': instance.disease_id,
      'disease_note_other': instance.disease_note_other,
      'date_of_surgery': instance.date_of_surgery.toIso8601String(),
      'staff_id': instance.staff_id,
      'case_id': instance.case_id,
      'disease_name': instance.disease_name,
      'surgery_type_name': instance.surgery_type_name,
      'staff_firstname': instance.staff_firstname,
      'staff_lastname': instance.staff_lastname,
      'stoma_id': instance.stoma_id,
      'stoma_type_name': instance.stoma_type_name,
      'stoma_type_note_other': instance.stoma_type_note_other,
      'username': instance.username,
    };
