import 'dart:convert';

import 'avatar_model.dart';

class User {
  Avatar? avatar;
  int? id;
  String? iso6391;
  String? iso31661;
  String? name;
  bool? includeAdult;
  String? username;

  User({
    this.avatar,
    this.id,
    this.iso6391,
    this.iso31661,
    this.name,
    this.includeAdult,
    this.username,
  });

  User.fromMap(Map<String, dynamic> json) {
    avatar = json['avatar'] != null ? Avatar.fromJson(json['avatar']) : null;
    id = json['id'];
    iso6391 = json['iso_639_1'];
    iso31661 = json['iso_3166_1'];
    name = json['name'];
    includeAdult = json['include_adult'];
    username = json['username'];
  }
  User.fromCash(this.id);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (avatar != null) {
      data['avatar'] = avatar!.toJson();
    }
    data['id'] = id;
    data['iso_639_1'] = iso6391;
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    data['include_adult'] = includeAdult;
    data['username'] = username;
    return data;
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
