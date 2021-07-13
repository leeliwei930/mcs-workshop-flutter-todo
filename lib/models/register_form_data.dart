import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'register_form_data.g.dart';

@JsonSerializable(
    ignoreUnannotated: true
)
class RegisterFormData {

  @JsonKey(name: "username")
  late String username;


  @JsonKey(name: "email")
  late String email;



  @JsonKey(name: "fullname")
  late String fullname;


  @JsonKey(name: "password")
  late String password;

  late String confirmPassword;

  late FocusNode usernameFocusNode;
  late FocusNode emailFocusNode;
  late FocusNode fullnameFocusNode;
  late FocusNode passwordFocusNode;
  late FocusNode confirmPasswordFocusNode;

  RegisterFormData({this.username = "", this.fullname = "", this.password = "", this.email = "", this.confirmPassword = ""}){
    this.usernameFocusNode = FocusNode();
    this.emailFocusNode = FocusNode();
    this.passwordFocusNode = FocusNode();
    this.fullnameFocusNode = FocusNode();
    this.confirmPasswordFocusNode = FocusNode();
  }

  factory RegisterFormData.fromJson(Map<String, dynamic> json) => _$RegisterFormDataFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterFormDataToJson(this);

  String toString() {
    return this.toJson().toString();
  }
}
