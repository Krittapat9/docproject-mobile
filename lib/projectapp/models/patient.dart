import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';


@JsonSerializable()
class Patient {
  final int id;
  final int staff_id;
  final String firstname;
  final String lastname;
  final String sex;
  final String date_of_birth;
  final String hospital_number;
  final DateTime date_of_registration;
  final String? email;

  Patient({
    required this.id,
    required this.staff_id,
    required this.firstname,
    required this.lastname,
    required this.sex,
    required this.date_of_birth,
    required this.hospital_number,
    required this.date_of_registration,
    required this.email,
  });


  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);
}