// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surgery.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Surgery _$SurgeryFromJson(Map<String, dynamic> json) => Surgery(
      id: (json['id'] as num).toInt(),
      patient_id: (json['patient_id'] as num).toInt(),
      surgery_type_id: (json['surgery_type_id'] as num).toInt(),
      surgery_type_note_other: json['surgery_type_note_other'] as String,
      disease_id: (json['disease_id'] as num).toInt(),
      disease_note_id: json['disease_note_id'] as String,
      date_of_surgery: DateTime.parse(json['date_of_surgery'] as String),
      staff_id: (json['staff_id'] as num).toInt(),
    );

Map<String, dynamic> _$SurgeryToJson(Surgery instance) => <String, dynamic>{
      'id': instance.id,
      'patient_id': instance.patient_id,
      'surgery_type_id': instance.surgery_type_id,
      'surgery_type_note_other': instance.surgery_type_note_other,
      'disease_id': instance.disease_id,
      'disease_note_id': instance.disease_note_id,
      'date_of_surgery': instance.date_of_surgery.toIso8601String(),
      'staff_id': instance.staff_id,
    };
