import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'password_form_data.g.dart';
@JsonSerializable(
  ignoreUnannotated: true
)
class PasswordFormData {

  @JsonKey(name: "password")
  String password;

  late FocusNode passwordFocusNode;

  @JsonKey(name: "newPassword")
  String newPassword;

  late FocusNode newPasswordFocusNode;

  @JsonKey(name: "confirmPassword")
  String confirmPassword;

  late FocusNode confirmPasswordFocusNode;

  PasswordFormData({this.password = "", this.newPassword = "", this.confirmPassword = ""}){
    this.passwordFocusNode = FocusNode();
    this.newPasswordFocusNode = FocusNode();
    this.confirmPasswordFocusNode = FocusNode();
  }

  String toString(){
    return this.toJson().toString();
  }

  factory PasswordFormData.fromJson(Map<String, dynamic> json) => _$PasswordFormDataFromJson(json);
  Map<String, dynamic> toJson() => _$PasswordFormDataToJson(this);

  void reset(){
    this.password = "";
    this.newPassword = "";
    this.confirmPassword = "";
  }

}
