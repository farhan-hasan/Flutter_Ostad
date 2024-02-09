// {
// "_id": "65c49d1f2d0f1c611885355c",
// "ProductName": "Samsung Galaxy S23",
// "ProductCode": "SMs23",
// "Img": "https://images.samsung.com/bd/smartphones/galaxy-s23-ultra/images/galaxy-s23-ultra-highlights-kv.jpg",
// "UnitPrice": "150000",
// "Qty": "4",
// "TotalPrice": "600000",
// "CreatedDate": "2024-02-07T15:31:47.241Z"
// }

class Product {
  String? id;
  String? productName;
  String? productCode;
  String? image;
  String? unitPrice;
  String? quantity;
  String? totalPrice;
  String? createdDate;

  Product({
  this.id,
  this.productCode,
  this.productName,
  this.quantity,
  this.totalPrice,
  this.unitPrice,
  this.createdDate,
  this.image
  });

  Product.fromJson(Map<String,dynamic> json) {
    id = json['_id'];
    productName = json['ProductName'];
    productCode = json['ProductCode'];
    image = json['Img'];
    unitPrice = json['UnitPrice'];
    quantity = json['Qty'];
    totalPrice = json['TotalPrice'];
    createdDate = json['CreatedDate'];
  }

  Map<String,dynamic> toJson() {
    return {
      "Img": image,
      "ProductCode": productCode,
      "ProductName": productName,
      "Qty": quantity,
      "TotalPrice": totalPrice,
      "UnitPrice": unitPrice,
      "_id": id,
    };
  }

}