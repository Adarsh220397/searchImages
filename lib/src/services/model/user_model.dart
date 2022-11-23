class UserModel {
  String image;
  String type;

  UserModel({
    required this.image,
    required this.type,
  });

  factory UserModel.fromJson(dynamic json) {
    return UserModel(
      image: json['image'] == null ? '' : json['image'] as String,
      type: json['path'] == null ? '' : json['path'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['image'] = image;
    data['path'] = type;

    return data;
  }
}
