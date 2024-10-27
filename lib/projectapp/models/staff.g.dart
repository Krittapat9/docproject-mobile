// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Staff _$StaffFromJson(Map<String, dynamic> json) => Staff(
      id: (json['id'] as num).toInt(),
      username: json['username'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      is_admin: (json['is_admin'] as num).toInt(),
      first_login: (json['first_login'] as num).toInt(),
    );

Map<String, dynamic> _$StaffToJson(Staff instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'is_admin': instance.is_admin,
      'first_login': instance.first_login,
    };
