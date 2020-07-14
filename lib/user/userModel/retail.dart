class RetailAttributes{

  final String email;
  final String mobile;
  final String productCode;
  final String purchasedOn;


  RetailAttributes({
   this.email,
   this.mobile,
   this.productCode,
   this.purchasedOn
  });
  
  factory RetailAttributes.fromJson(Map<String, dynamic> json) {
    return RetailAttributes(
      email: json['email'],
      mobile: json['mobile'],
      productCode: json['productCode'],
      purchasedOn: json['purchasedOn'],
    );
  }

  Map<String, dynamic> toMap() =>{
    "email":email,
    "mobile":mobile,
    "productCode":productCode,
    "purchasedOn":purchasedOn,
  };
}