// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stoma.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Stoma _$StomaFromJson(Map<String, dynamic> json) => Stoma(
      id: (json['id'] as num).toInt(),
      surgery_id: (json['surgery_id'] as num).toInt(),
      surgery_type_id: (json['surgery_type_id'] as num).toInt(),
      stoma_type_note_other: json['stoma_type_note_other'] as String?,
    );

Map<String, dynamic> _$StomaToJson(Stoma instance) => <String, dynamic>{
      'id': instance.id,
      'surgery_id': instance.surgery_id,
      'surgery_type_id': instance.surgery_type_id,
      'stoma_type_note_other': instance.stoma_type_note_other,
    };
