import 'package:json_annotation/json_annotation.dart';

part 'staff_name.g.dart';


@JsonSerializable()
class StaffName {
  final String firstname;
  final String lastname;

  StaffName({
    required this.firstname,
    required this.lastname,
  });

  factory StaffName.fromJson(Map<String, dynamic> json) => _$StaffNameFromJson(json);

  Map<String, dynamic> toJson() => _$StaffNameToJson(this);}