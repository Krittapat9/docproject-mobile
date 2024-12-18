import 'package:json_annotation/json_annotation.dart';

part 'patient.g.dart';


@JsonSerializable()
class Patient {
  final int id;
  final int staff_id;
  final String firstname;
  final String lastname;
  final String sex;
  final DateTime date_of_birth;
  final String hospital_number;
  final DateTime date_of_registration;
  final String? email;

  final String? staff_firstname;
  final String? staff_lastname;
  final String? image_patient;



  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);

  Patient({required this.id, required this.staff_id, required this.firstname, required this.lastname, required this.sex, required this.date_of_birth, required this.hospital_number, required this.date_of_registration, required this.email, required this.staff_firstname, required this.staff_lastname, required this.image_patient});


}