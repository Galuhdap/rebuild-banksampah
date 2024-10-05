// To parse this JSON data, do
//
//     final postProductResponse = postProductResponseFromJson(jsonString);

import 'dart:convert';

PostProductResponse postProductResponseFromJson(String str) => PostProductResponse.fromJson(json.decode(str));

String postProductResponseToJson(PostProductResponse data) => json.encode(data.toJson());

class PostProductResponse {
    final bool success;
    final int code;
    final String message;
    final PostProduct data;

    PostProductResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    PostProductResponse copyWith({
        bool? success,
        int? code,
        String? message,
        PostProduct? data,
    }) => 
        PostProductResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PostProductResponse.fromJson(Map<String, dynamic> json) => PostProductResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: PostProduct.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class PostProduct {
    final String id;
    final String idImage;
    final String name;
    final String image;
    final int stock;
    final int price;
    final DateTime createdAt;
    final DateTime updatedAt;

    PostProduct({
        required this.id,
        required this.idImage,
        required this.name,
        required this.image,
        required this.stock,
        required this.price,
        required this.createdAt,
        required this.updatedAt,
    });

    PostProduct copyWith({
        String? id,
        String? idImage,
        String? name,
        String? image,
        int? stock,
        int? price,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        PostProduct(
            id: id ?? this.id,
            idImage: idImage ?? this.idImage,
            name: name ?? this.name,
            image: image ?? this.image,
            stock: stock ?? this.stock,
            price: price ?? this.price,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory PostProduct.fromJson(Map<String, dynamic> json) => PostProduct(
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