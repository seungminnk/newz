import 'package:json_annotation/json_annotation.dart';
import 'package:newz/application/user/model/token.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String name;
  final String email;
  final bool haveKeywords;
  final Token tokens;

  User(this.id, this.name, this.email, this.haveKeywords, this.tokens);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
