// To parse this JSON data, do
//
//     final getProductBuyCustomerResponse = getProductBuyCustomerResponseFromJson(jsonString);

import 'dart:convert';

GetProductBuyCustomerResponse getProductBuyCustomerResponseFromJson(String str) => GetProductBuyCustomerResponse.fromJson(json.decode(str));

String getProductBuyCustomerResponseToJson(GetProductBuyCustomerResponse data) => json.encode(data.toJson());

class GetProductBuyCustomerResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    GetProductBuyCustomerResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetProductBuyCustomerResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        GetProductBuyCustomerResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetProductBuyCustomerResponse.fromJson(Map<String, dynamic> json) => GetProductBuyCustomerResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    final String userId;
    final String status;
    final String orderCode;
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<TransactionProduct> transactionProduct;
    final String transactionId;

    Data({
        required this.userId,
        required this.status,
        required this.orderCode,
        required this.createdAt,
        required this.updatedAt,
        required this.transactionProduct,
        required this.transactionId,
    });

    Data copyWith({
        String? userId,
        String? status,
        String? orderCode,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<TransactionProduct>? transactionProduct,
        String? transactionId,
    }) => 
        Data(
            userId: userId ?? this.userId,
            status: status ?? this.status,
            orderCode: orderCode ?? this.orderCode,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            transactionProduct: transactionProduct ?? this.transactionProduct,
            transactionId: transactionId ?? this.transactionId,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"],
        status: json["status"],
        orderCode: json["orderCode"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        transactionProduct: List<TransactionProduct>.from(json["TransactionProduct"].map((x) => TransactionProduct.fromJson(x))),
        transactionId: json["transactionId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "status": status,
        "orderCode": orderCode,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "TransactionProduct": List<dynamic>.from(transactionProduct.map((x) => x.toJson())),
        "transactionId": transactionId,
    };
}

class TransactionProduct {
    final String id;
    final String productId;
    final int quantity;
    final int price;
    final DateTime createdAt;
    final Product product;

    TransactionProduct({
        required this.id,
        required this.productId,
        required this.quantity,
        required this.price,
        required this.createdAt,
        required this.product,
    });

    TransactionProduct copyWith({
        String? id,
        String? productId,
        int? quantity,
        int? price,
        DateTime? createdAt,
        Product? product,
    }) => 
        TransactionProduct(
            id: id ?? this.id,
            productId: productId ?? this.productId,
            quantity: quantity ?? this.quantity,
            price: price ?? this.price,
            createdAt: createdAt ?? this.createdAt,
            product: product ?? this.product,
        );

    factory TransactionProduct.fromJson(Map<String, dynamic> json) => TransactionProduct(
        id: json["id"],
        productId: json["productId"],
        quantity: json["quantity"],
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        product: Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "productId": productId,
        "quantity": quantity,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
        "product": product.toJson(),
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
