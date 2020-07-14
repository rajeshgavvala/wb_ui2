class OwnerAttributes{

  final String email;
  final String mobile;
  final String password;

  OwnerAttributes({this.email, this.mobile, this.password});
  
  factory OwnerAttributes.fromJson(Map<String, dynamic> json) {
    return OwnerAttributes(
      email: json['email'],
      mobile: json['mobile'],
      password: json['password'],
    );
  }
}