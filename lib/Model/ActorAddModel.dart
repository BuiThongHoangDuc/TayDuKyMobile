class ActorAddModel {
  final String usName, usEmail, usPass, usAddress, usPhoneNum, usDes, usImage,createBy,updateBy,updateTime;
  final int usID;

  ActorAddModel(
      {this.usID,
      this.usName,
      this.usEmail,
      this.usAddress,
      this.usDes,
      this.usImage,
      this.usPass,
      this.usPhoneNum,
      this.createBy,
      this.updateBy,
      this.updateTime});

  Map<String, dynamic> toJson() => {
        "UserId": usID,
        "UserName": usName,
        "UserImage": usImage,
        "UserDescription": usDes,
        "UserPhoneNum": usPhoneNum,
        "UserEmail": usEmail,
        "UserPassword": usPass,
        "UserAdress": usAddress,
        "UserUpdateTime": updateTime,
        "UserCreateBy": createBy,
        "UserUpdateBy": updateBy,
      };

  factory ActorAddModel.fromJson(Map<String, dynamic> json) {
    return ActorAddModel(
      usID: json['userId'] as int,
      usName: json['userName'] as String,
      usImage: json['userImage'] as String,
      usDes: json['userDescription'] as String,
      usPhoneNum: json['userPhoneNum'] as String,
      usEmail: json['userEmail'] as String,
      usPass: json['userPassword'] as String,
      usAddress: json['userAdress'] as String,
      createBy: json['userCreateBy'] as String,
      updateBy: json['userUpdateBy'] as String,
      updateTime: json['userUpdateTime'] as String
    );
  }
}
