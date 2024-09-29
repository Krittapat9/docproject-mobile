import 'package:code/projectapp/models/patient.dart';
import 'package:code/projectapp/models/surgery.dart';
import 'package:code/projectapp/models/medical_history.dart';
import 'package:json_annotation/json_annotation.dart';

part 'surgery_medical_history.g.dart';

@JsonSerializable()
class SurgeryMedicalHistory {
  final Patient patient;
  final Surgery surgery;
  final List<MedicalHistory> medical_history;


  factory SurgeryMedicalHistory.fromJson(Map<String, dynamic> json) =>
      _$SurgeryMedicalHistoryFromJson(json);

  SurgeryMedicalHistory({required this.patient, required this.surgery, required this.medical_history});

  @override
  String toString() {
    return 'SurgeryMedicalHistory{patient: $patient, surgery: $surgery, medical_history: $medical_history}';
  }
}
