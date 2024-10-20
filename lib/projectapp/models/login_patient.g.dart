// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginPatient _$LoginPatientFromJson(Map<String, dynamic> json) => LoginPatient(
      status: json['status'] as String,
      message: json['message'] as String,
      patient: Patient.fromJson(json['patient'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginPatientToJson(LoginPatient instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'patient': instance.patient,
    };
