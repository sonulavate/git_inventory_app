import 'dart:convert';

class ProductModel {
  String id;
  String name;
  String category;
  double price;
  int stock;
  String createdAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'stock': stock,
      'createdAt': createdAt,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      price: map['price'],
      stock: map['stock'],
      createdAt: map['createdAt'],
    );
  }

  String toJson() => json.encode(toMap());
  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
