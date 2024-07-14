import 'package:json_annotation/json_annotation.dart';

part 'staff.g.dart';


@JsonSerializable()
class Staff {
  final int id;
  final String username;
  final String firstname;
  final String lastname;
  final String pin;

  Staff({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.pin,
  });

  factory Staff.fromJson(Map<String, dynamic> json) => _$StaffFromJson(json);

  Map<String, dynamic> toJson() => _$StaffToJson(this);
}
