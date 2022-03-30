import 'gravater_model.dart';

class Avatar {
  Gravatar? gravatar;

  Avatar({this.gravatar});

  Avatar.fromJson(Map<String, dynamic> json) {
    gravatar =
        json['gravatar'] != null ? Gravatar.fromJson(json['gravatar']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (gravatar != null) {
      data['gravatar'] = gravatar!.toJson();
    }
    return data;
  }
}
