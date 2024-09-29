// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surgery_medical_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurgeryMedicalHistory _$SurgeryMedicalHistoryFromJson(
        Map<String, dynamic> json) =>
    SurgeryMedicalHistory(
      patient: Patient.fromJson(json['patient'] as Map<String, dynamic>),
      surgery: Surgery.fromJson(json['surgery'] as Map<String, dynamic>),
      medical_history: (json['medical_history'] as List<dynamic>)
          .map((e) => MedicalHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SurgeryMedicalHistoryToJson(
        SurgeryMedicalHistory instance) =>
    <String, dynamic>{
      'patient': instance.patient,
      'surgery': instance.surgery,
      'medical_history': instance.medical_history,
    };
