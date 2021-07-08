import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  late int id;

  @JsonKey(name: "fullname")
  late String fullname;
  @JsonKey(name: "username")
  late String username;

  @JsonKey(name: "email")
  late String email;

  @JsonKey(name: "blocked")
  late bool? blocked;

  User({required this.id, required this.username, required this.email, this.blocked, required this.fullname});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);


  String toString(){
    return this.toJson().toString();
  }
}
