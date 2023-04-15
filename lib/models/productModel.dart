class ProductModel {
  String? imageurl;
  String? itemName;
  String? category;
  String? description;
  String? condition;
  String? price;
  String? location;
  String? sellerId;
  String? productId;
  DateTime? listedDate;

  ProductModel({
    this.imageurl,
    this.itemName,
    this.category,
    this.description,
    this.condition,
    this.price,
    this.location,
    this.sellerId,
    this.productId,
    this.listedDate,
  });

  ProductModel.fromMap(Map<String, dynamic> map) {
    imageurl = map['ProductImage'];
    itemName = map['ProductName'];
    category = map['ProductCategory'];
    description = map['ProductDescription'];
    condition = map['ProductCondition'];
    price = map['ProductPrice'];
    location = map['Location'];
    sellerId = map['ProductSellerId'];
    productId = map['ProductID'];
    listedDate = map['ListedDate'];
  }

  Map<String, dynamic> toMap() {
    return {
      'ProductImage':imageurl,
      'ProductName':itemName,
      'ProductCategory':category,
      'ProductDescription':description,
      'ProductCondition':condition,
      'ProductPrice':price,
      'Location':location,
      'ProductSellerId':sellerId,
      'ProductID':productId,
      'ListedDate':listedDate,
    };
  }
}
