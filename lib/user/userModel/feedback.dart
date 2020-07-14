class RateReview{

  final String pType;
  final String rate;
  final String review;
  

  RateReview({
    this.pType,
    this.rate,
    this.review,

  });
  
  factory RateReview.fromJson(Map<String, dynamic> json) {
    return RateReview(
      pType: json['pType'],
      rate: json['rate'],
      review: json['review'],
     
    );
  }

  Map<String, dynamic> toMap() =>{
    "pType":pType,
    "rate":rate,
    "review":review,

  };
}