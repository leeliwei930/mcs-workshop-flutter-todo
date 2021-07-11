import 'package:json_annotation/json_annotation.dart';

part 'password_form_data.g.dart';
@JsonSerializable()
class PasswordFormData {

  @JsonKey(name: "password")
  String password;

  @JsonKey(name: "newPassword")
  String newPassword;

  @JsonKey(name: "confirmPassword")
  String confirmPassword;

  PasswordFormData({this.password = "", this.newPassword = "", this.confirmPassword = ""});

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
