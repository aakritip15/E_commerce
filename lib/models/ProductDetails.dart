// ignore_for_file: prefer_for_elements_to_map_fromiterable, non_constant_identifier_names
class Products {
  String? ProductName;
  String? ProductPrice;
  String? ProductDescription;
  String? ProductImage;
  String? ProductCategory;
  String? ProductID;
  String? ProductSellerID;
  String? ListedDate;
  String? ItemCondition;
  String? ListedLocation;
  String? ProductSellerName;

  Products(
      {this.ProductName,
      this.ProductPrice,
      this.ProductDescription,
      this.ProductImage,
      this.ProductCategory,
      this.ProductID,
      this.ProductSellerID,
      this.ListedDate,
      this.ItemCondition,
      this.ListedLocation,
      this.ProductSellerName});

  Products.fromMap(Map<String, dynamic> map) {
    ProductName = map["ProductName"];
    ProductPrice = map["ProductPrice"];
    ProductDescription = map["ProductDescription"];
    ProductImage = map["ProductImage"];
    ProductCategory = map["ProductCategory"];
    ProductID = map["ProductID"];
    ProductSellerID = map["ProductSellerID"];
    ListedDate = map["ListedDate"];
    ItemCondition = map["ItemCondition"];
    ListedLocation = map["ListedLocation"];
    ProductSellerName = map["ProductSellerName"];
  }

  Map<String, dynamic> toMap() {
    return {
      "ProductName": ProductName,
      "ProductPrice": ProductPrice,
      "ProductDescription": ProductDescription,
      "ProductImage": ProductImage,
      "ProductCategory": ProductCategory,
      "ProductID": ProductID,
      "ProductSellerID": ProductSellerID,
      "ListedDate": ListedDate,
      "ItemCondition": ItemCondition,
      "ListedLocation": ListedLocation,
      "ProductSellerName": ProductSellerName
    };
  }
}
