// To parse this JSON data, do
//
//     final getOrderCustomerResponse = getOrderCustomerResponseFromJson(jsonString);

import 'dart:convert';

GetOrderCustomerResponse getOrderCustomerResponseFromJson(String str) => GetOrderCustomerResponse.fromJson(json.decode(str));

String getOrderCustomerResponseToJson(GetOrderCustomerResponse data) => json.encode(data.toJson());

class GetOrderCustomerResponse {
    final bool success;
    final int code;
    final String message;
    final List<OrderCustomer> data;

    GetOrderCustomerResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetOrderCustomerResponse copyWith({
        bool? success,
        int? code,
        String? message,
        List<OrderCustomer>? data,
    }) => 
        GetOrderCustomerResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetOrderCustomerResponse.fromJson(Map<String, dynamic> json) => GetOrderCustomerResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<OrderCustomer>.from(json["data"].map((x) => OrderCustomer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class OrderCustomer {
    final String transactionId;
    final String status;
    final DateTime createdAt;
    final String orderCode;
    final int totalPrice;
    final List<Product> products;

    OrderCustomer({
        required this.transactionId,
        required this.status,
        required this.createdAt,
        required this.orderCode,
        required this.totalPrice,
        required this.products,
    });

    OrderCustomer copyWith({
        String? transactionId,
        String? status,
        DateTime? createdAt,
        String? orderCode,
        int? totalPrice,
        List<Product>? products,
    }) => 
        OrderCustomer(
            transactionId: transactionId ?? this.transactionId,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            orderCode: orderCode ?? this.orderCode,
            totalPrice: totalPrice ?? this.totalPrice,
            products: products ?? this.products,
        );

    factory OrderCustomer.fromJson(Map<String, dynamic> json) => OrderCustomer(
        transactionId: json["transactionId"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        orderCode: json["orderCode"],
        totalPrice: json["totalPrice"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "orderCode": orderCode,
        "totalPrice": totalPrice,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    final String productId;
    final String name;
    final String image;
    final int price;
    final int quantity;
    final DateTime createdAt;

    Product({
        required this.productId,
        required this.name,
        required this.image,
        required this.price,
        required this.quantity,
        required this.createdAt,
    });

    Product copyWith({
        String? productId,
        String? name,
        String? image,
        int? price,
        int? quantity,
        DateTime? createdAt,
    }) => 
        Product(
            productId: productId ?? this.productId,
            name: name ?? this.name,
            image: image ?? this.image,
            price: price ?? this.price,
            quantity: quantity ?? this.quantity,
            createdAt: createdAt ?? this.createdAt,
        );

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["productId"],
        name: json["name"],
        image: json["image"],
        price: json["price"],
        quantity: json["quantity"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "name": name,
        "image": image,
        "price": price,
        "quantity": quantity,
        "createdAt": createdAt.toIso8601String(),
    };
}
