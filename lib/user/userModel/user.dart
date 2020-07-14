class UserAttributes{

  final String email;
  final String mobile;
  final String password;

  UserAttributes({this.email, this.mobile, this.password});
  
  factory UserAttributes.fromJson(Map<String, dynamic> json) {
    return UserAttributes(
      email: json['email'],
      mobile: json['mobile'],
      password: json['password'],
    );
  }
}