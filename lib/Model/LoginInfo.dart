class LoginInfo {
  final String userEmail, userPassword;

  LoginInfo({
    this.userEmail,
    this.userPassword,
  });

  Map<String, dynamic> toJson() =>
      {"userEmail": userEmail, "userPassword": userPassword};
}
