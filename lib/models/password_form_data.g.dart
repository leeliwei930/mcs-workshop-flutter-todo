// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_form_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordFormData _$PasswordFormDataFromJson(Map<String, dynamic> json) {
  return PasswordFormData(
    password: json['password'] as String,
    newPassword: json['newPassword'] as String,
    confirmPassword: json['confirmPassword'] as String,
  );
}

Map<String, dynamic> _$PasswordFormDataToJson(PasswordFormData instance) =>
    <String, dynamic>{
      'password': instance.password,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };
