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
}
