import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String loginType;
  final String name;
  final String email;
  final bool completeOnboarding;

  User(this.id, this.loginType, this.name, this.email, this.completeOnboarding);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
