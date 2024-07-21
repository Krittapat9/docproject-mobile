import 'package:json_annotation/json_annotation.dart';

part 'staff.g.dart';


@JsonSerializable()
class Staff {
  final int id;
  final String username;
  final String firstname;
  final String lastname;
  final int is_admin;

  Staff({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.is_admin,
  });

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);

  Map<String, dynamic> toJson() => _$StaffToJson(this);}