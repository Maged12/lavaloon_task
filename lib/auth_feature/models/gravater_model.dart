class Gravatar {
  String? hash;

  Gravatar({this.hash});

  Gravatar.fromJson(Map<String, dynamic> json) {
    hash = json['hash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hash'] = hash;
    return data;
  }
}
