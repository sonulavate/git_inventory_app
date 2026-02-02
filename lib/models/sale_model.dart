import 'dart:convert';

class SaleModel {
  String productId;
  String productName;
  int quantity;
  String date;

  SaleModel({
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'date': date,
    };
  }

  factory SaleModel.fromMap(Map<String, dynamic> map) {
    return SaleModel(
      productId: map['productId'],
      productName: map['productName'],
      quantity: map['quantity'],
      date: map['date'],
    );
  }

  String toJson() => json.encode(toMap());
  factory SaleModel.fromJson(String source) =>
      SaleModel.fromMap(json.decode(source));
}
