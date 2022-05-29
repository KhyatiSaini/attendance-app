class UserImageModel {
  String email;
  List imageModel;

  UserImageModel({
    required this.email,
    required this.imageModel,
  });

  factory UserImageModel.fromJson(Map<dynamic, dynamic> data) {
    return UserImageModel(
      email: data['mail'],
      imageModel: data['image'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['mail'] = email;
    data['image'] = imageModel;
    return data;
  }

  @override
  String toString() {
    return 'UserImageModel{email: $email, imageModel: $imageModel}';
  }
}
