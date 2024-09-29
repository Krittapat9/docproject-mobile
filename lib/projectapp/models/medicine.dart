import 'package:json_annotation/json_annotation.dart';

part 'medicine.g.dart';

@JsonSerializable()
class Medicine {
  final int id;
  final String name;
  final String details;

  factory Medicine.fromJson(Map<String, dynamic> json) =>
      _$MedicineFromJson(json);

  Medicine({required this.id, required this.name, required this.details});
}
