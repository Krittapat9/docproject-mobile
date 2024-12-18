// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Patient _$PatientFromJson(Map<String, dynamic> json) => Patient(
      id: (json['id'] as num).toInt(),
      staff_id: (json['staff_id'] as num).toInt(),
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      sex: json['sex'] as String,
      date_of_birth: DateTime.parse(json['date_of_birth'] as String),
      hospital_number: json['hospital_number'] as String,
      date_of_registration:
          DateTime.parse(json['date_of_registration'] as String),
      email: json['email'] as String?,
      staff_firstname: json['staff_firstname'] as String?,
      staff_lastname: json['staff_lastname'] as String?,
      image_patient: json['image_patient'] as String?,
    );

Map<String, dynamic> _$PatientToJson(Patient instance) => <String, dynamic>{
      'id': instance.id,
      'staff_id': instance.staff_id,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'sex': instance.sex,
      'date_of_birth': instance.date_of_birth.toIso8601String(),
      'hospital_number': instance.hospital_number,
      'date_of_registration': instance.date_of_registration.toIso8601String(),
      'email': instance.email,
      'staff_firstname': instance.staff_firstname,
      'staff_lastname': instance.staff_lastname,
      'image_patient': instance.image_patient,
    };
