import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'work_schedule.g.dart';


@JsonSerializable()
class WorkSchedule {
  final int id;
  final int staff_id;
  final int patient_id;
  final DateTime work_date;
  final String start_time;
  final String end_time;
  final String detail;

  final String patient_firstname;
  final String patient_lastname;



  factory WorkSchedule.fromJson(Map<String, dynamic> json) => _$WorkScheduleFromJson(json);

  WorkSchedule({required this.id, required this.staff_id, required this.patient_id, required this.work_date, required this.start_time, required this.end_time, required this.detail, required this.patient_firstname, required this.patient_lastname});


}