class ActorAddModel {
  final String usName, usEmail, usPass, usAddress, usPhoneNum, usDes, usImage;
  final int usID;

  ActorAddModel(
      {this.usID,
      this.usName,
      this.usEmail,
      this.usAddress,
      this.usDes,
      this.usImage,
      this.usPass,
      this.usPhoneNum});

  Map<String, dynamic> toJson() => {
        "UserId": usID,
        "UserName": usName,
        "UserImage": usImage,
        "UserDescription": usDes,
        "UserPhoneNum": usPhoneNum,
        "UserEmail": usEmail,
        "UserPassword": usPass,
        "UserAdress": usAddress
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
    );
  }
}
