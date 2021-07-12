// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterFormData _$RegisterFormDataFromJson(Map<String, dynamic> json) {
  return RegisterFormData(
    username: json['username'] as String,
    fullname: json['fullname'] as String,
    password: json['password'] as String,
    email: json['email'] as String,
  );
}

Map<String, dynamic> _$RegisterFormDataToJson(RegisterFormData instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'fullname': instance.fullname,
      'password': instance.password,
    };
