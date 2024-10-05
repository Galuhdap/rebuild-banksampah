// To parse this JSON data, do
//
//     final getProductResponse = getProductResponseFromJson(jsonString);

import 'dart:convert';

GetProductResponse getProductResponseFromJson(String str) => GetProductResponse.fromJson(json.decode(str));

String getProductResponseToJson(GetProductResponse data) => json.encode(data.toJson());

class GetProductResponse {
    final bool success;
    final int code;
    final String message;
    final List<Product> data;

    GetProductResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetProductResponse copyWith({
        bool? success,
        int? code,
        String? message,
        List<Product>? data,
    }) => 
        GetProductResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetProductResponse.fromJson(Map<String, dynamic> json) => GetProductResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<Product>.from(json["data"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Product {
    final String id;
    final String idImage;
    final String name;
    final String image;
    final int stock;
    final int price;
    final DateTime createdAt;
    final DateTime updatedAt;

    Product({
        required this.id,
        required this.idImage,
        required this.name,
        required this.image,
        required this.stock,
        required this.price,
        required this.createdAt,
        required this.updatedAt,
    });

    Product copyWith({
        String? id,
        String? idImage,
        String? name,
        String? image,
        int? stock,
        int? price,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Product(
            id: id ?? this.id,
            idImage: idImage ?? this.idImage,
            name: name ?? this.name,
            image: image ?? this.image,
            stock: stock ?? this.stock,
            price: price ?? this.price,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        idImage: json["idImage"],
        name: json["name"],
        image: json["image"],
        stock: json["stock"],
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "idImage": idImage,
        "name": name,
        "image": image,
        "stock": stock,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
