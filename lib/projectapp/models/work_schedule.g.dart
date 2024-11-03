// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorkSchedule _$WorkScheduleFromJson(Map<String, dynamic> json) => WorkSchedule(
      id: (json['id'] as num).toInt(),
      staff_id: (json['staff_id'] as num).toInt(),
      patient_id: (json['patient_id'] as num).toInt(),
      work_date: DateTime.parse(json['work_date'] as String),
      start_time: json['start_time'] as String,
      end_time: json['end_time'] as String,
      detail: json['detail'] as String,
      patient_firstname: json['patient_firstname'] as String,
      patient_lastname: json['patient_lastname'] as String,
      patient_email: json['patient_email'] as String,
    );

Map<String, dynamic> _$WorkScheduleToJson(WorkSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'staff_id': instance.staff_id,
      'patient_id': instance.patient_id,
      'work_date': instance.work_date.toIso8601String(),
      'start_time': instance.start_time,
      'end_time': instance.end_time,
      'detail': instance.detail,
      'patient_firstname': instance.patient_firstname,
      'patient_lastname': instance.patient_lastname,
      'patient_email': instance.patient_email,
    };
