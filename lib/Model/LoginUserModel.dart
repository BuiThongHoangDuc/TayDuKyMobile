import 'dart:convert';

class LoginUserModel {
  final String userName, userImage,userEmail;
  final int userId, userRole;

  LoginUserModel({
    this.userId,
    this.userName,
    this.userEmail,
    this.userImage,
    this.userRole,
  });

  Map<String, dynamic> toJson() =>
      {"userId": userId, "userName": userName, "userEmail": userEmail, "userImage": userImage, "userRole": userRole};

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      userEmail: json['userEmail'] as String,
      userImage: json['userImage'] as String,
      userRole: json['userRole'] as int,
    );
  }
}
