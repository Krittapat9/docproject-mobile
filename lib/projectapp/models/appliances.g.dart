// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appliances.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appliances _$AppliancesFromJson(Map<String, dynamic> json) => Appliances(
      id: (json['id'] as num).toInt(),
      type: json['type'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String,
      name_flange: json['name_flange'] as String,
      name_pouch: json['name_pouch'] as String,
      size: json['size'] as String,
    );

Map<String, dynamic> _$AppliancesToJson(Appliances instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'name': instance.name,
      'brand': instance.brand,
      'name_flange': instance.name_flange,
      'name_pouch': instance.name_pouch,
      'size': instance.size,
    };
