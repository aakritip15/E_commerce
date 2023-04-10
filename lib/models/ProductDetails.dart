// ignore_for_file: prefer_for_elements_to_map_fromiterable, non_constant_identifier_names

class Products {
  String? ProductName;
  String? ProductPrice;
  String? ProductDescription;
  List<String>? ProductImage;
  String? ProductCategory;
  String? ProductID;
  String? ProductSellerID;
  String? ListedDate;

  Products(
      {this.ProductName,
      this.ProductPrice,
      this.ProductDescription,
      this.ProductImage,
      this.ProductCategory,
      this.ProductID,
      this.ProductSellerID,
      this.ListedDate});

  Products.fromMap(Map<String, dynamic> map) {
    ProductName = map["ProductName"];
    ProductPrice = map["ProductPrice"];
    ProductDescription = map["ProductDescription"];
    ProductImage = List<String>.from(map["ProductImage"]);
    ProductCategory = map["ProductCategory"];
    ProductID = map["ProductID"];
    ProductSellerID = map["ProductSellerID"];
    ListedDate = map["ListedDate"];
  }

  Map<String, dynamic> toMap() {
    return {
      "ProductName": ProductName,
      "ProductPrice": ProductPrice,
      "ProductDescription": ProductDescription,
      "ProductImage": Map<String, dynamic>.fromIterable(
        ProductImage!,
        key: (ProductImage) => ProductImage,
        value: (_) => true,
      ),
      "ProductCategory": ProductCategory,
      "ProductID": ProductID,
      "ProductSellerID": ProductSellerID,
      "ListedDate": ListedDate,
    };
  }
}
