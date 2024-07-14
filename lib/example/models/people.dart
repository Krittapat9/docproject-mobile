
import 'package:json_annotation/json_annotation.dart';

part 'people.g.dart';

@JsonSerializable()
class People {
  final String name;
  final String height;
  final String mass;

  @JsonKey(name: 'hair_color')
  final String hairColor;

  @JsonKey(name: 'birth_year')
  final String birthYear;




  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);

  People({required this.name,
    required this.height,
    required this.mass,
    required this.hairColor,
    required this.birthYear
  });


  Map<String, dynamic> toJson() => _$PeopleToJson(this);
}
