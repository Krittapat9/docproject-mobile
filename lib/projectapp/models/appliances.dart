import 'package:json_annotation/json_annotation.dart';

part 'appliances.g.dart';

@JsonSerializable()
class Appliances {
  final int id;
  final String type;
  final String name;
  final String brand;
  final String name_flange;
  final String name_pouch;
  final String size;

  Appliances(
      {required this.id,
        required this.type,
        required this.name,
        required this.brand,
        required this.name_flange,
        required this.name_pouch,
        required this.size});

  factory Appliances.fromJson(Map<String, dynamic> json) =>
      _$AppliancesFromJson(json);

}
