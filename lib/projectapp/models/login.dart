import 'package:code/projectapp/models/staff.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';

@JsonSerializable()
class Login {
  final String status;
  final String message;
  final Staff staff;

  Login({required this.status, required this.message, required this.staff});

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);
}
