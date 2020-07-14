class IssueAttributes{

  final String productId;
  final String issueId;
  final String date;
  final String location;
  final String image;
  final String description;

  

  IssueAttributes({
    this.productId,
    this.issueId,
    this.date,
    this.location,
    this.image,
    this.description
  });
  
  factory IssueAttributes.fromJson(Map<String, dynamic> json) {
    return IssueAttributes(
      productId:json['productId'],
      issueId: json['issueId'],
      date: json['date'],
      location: json['location'],
      image: json['image'],
      description: json['description']
    );
  }

  Map<String, dynamic> toMap() =>{
    "productId":productId,
    "issueId":issueId,
    "date":date,
    "location":location,
    "image":image,
    "description":description,

  };
}