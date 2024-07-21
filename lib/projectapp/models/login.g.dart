// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Login _$LoginFromJson(Map<String, dynamic> json) => Login(
      status: json['status'] as String,
      message: json['message'] as String,
      staff: Staff.fromJson(json['staff'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginToJson(Login instance) => <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'staff': instance.staff,
    };
