import 'dart:io';

class ProductRequest {
  String name;
  int price;
  int stock;
  File? image;

  ProductRequest({required this.name, required this.price, required this.stock, this.image});

  Map<String, String> toJson() => {
        "name": name,
        "price": price.toString(),
        "stock": stock.toString(),
        "image": image!.path,
      };
}
