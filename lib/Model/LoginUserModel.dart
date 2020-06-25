class LoginUserModel {
  final String userName, userImage;
  final int userId, userRole;

  LoginUserModel({
    this.userId,
    this.userName,
    this.userImage,
    this.userRole,
  });

  Map<String, dynamic> toJson() =>
      {"userId": userId, "userName": userName, "userImage": userImage, "userRole": userRole};

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      userImage: json['userImage'] as String,
      userRole: json['userRole'] as int,
    );
  }
}
