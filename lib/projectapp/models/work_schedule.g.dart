// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      id: (json['id'] as num).toInt(),
      staff_id: (json['staff_id'] as num).toInt(),
      patient_id: json['patient_id'] as String,
      work_date: json['work_date'] as String,
      start_time: json['start_time'] as String,
      end_time: json['end_time'] as String,
      detail: json['detail'] as String,
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'staff_id': instance.staff_id,
      'patient_id': instance.patient_id,
      'work_date': instance.work_date,
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'detail': instance.detail,
    };
