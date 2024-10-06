import 'package:json_annotation/json_annotation.dart';

part 'work_schedule.g.dart';


@JsonSerializable()
class Patient {
  final int id;
  final int staff_id;
  final String patient_id;
  final String work_date;
  final String start_time;
  final String end_time;
  final String detail;



  factory Patient.fromJson(Map<String, dynamic> json) => _$PatientFromJson(json);

  Patient({required this.id, required this.staff_id, required this.patient_id, required this.work_date, required this.start_time, required this.end_time, required this.detail});
}