import 'package:json_annotation/json_annotation.dart';

part 'mucocutaneous_suture_line.g.dart';

@JsonSerializable()
class MucocutaneousSutureLine {
  final int id;
  final String name;

  MucocutaneousSutureLine({
    required this.id,
    required this.name});

  factory MucocutaneousSutureLine.fromJson(Map<String, dynamic> json) => _$MucocutaneousSutureLineFromJson(json);
}