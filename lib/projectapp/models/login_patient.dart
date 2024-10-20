import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/models/staff.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_patient.g.dart';

@JsonSerializable()
class LoginPatient {
  final String status;
  final String message;
  final Patient patient;


  factory LoginPatient.fromJson(Map<String, dynamic> json) => _$LoginPatientFromJson(json);

  LoginPatient({required this.status, required this.message, required this.patient});
}
