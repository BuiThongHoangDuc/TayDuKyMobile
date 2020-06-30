class UserBasicModel {
  final String userName, userImage, userEmail;
  final int userId;

  UserBasicModel({this.userId, this.userName, this.userImage, this.userEmail});

  factory UserBasicModel.fromJson(Map<String, dynamic> json) {
    return UserBasicModel(
      userId: json['userId'] as int,
      userName: json['userName'] as String,
      userImage: json['userImage'] as String,
      userEmail: json['userEmail'] as String,
    );
  }
}
