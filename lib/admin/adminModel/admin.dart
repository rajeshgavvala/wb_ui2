class AdminAttributes{

  final String email;
  final String mobile;
  final String password;

  AdminAttributes({this.email, this.mobile, this.password});
  
  factory AdminAttributes.fromJson(Map<String, dynamic> json) {
    return AdminAttributes(
      email: json['email'],
      mobile: json['mobile'],
      password: json['password'],
    );
  }
}