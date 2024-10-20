// To parse this JSON data, do
//
//     final getOrderAdminResponse = getOrderAdminResponseFromJson(jsonString);

import 'dart:convert';

GetOrderAdminResponse getOrderAdminResponseFromJson(String str) => GetOrderAdminResponse.fromJson(json.decode(str));

String getOrderAdminResponseToJson(GetOrderAdminResponse data) => json.encode(data.toJson());

class GetOrderAdminResponse {
    final bool success;
    final int code;
    final String message;
    final List<OrderAdmin> data;

    GetOrderAdminResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetOrderAdminResponse copyWith({
        bool? success,
        int? code,
        String? message,
        List<OrderAdmin>? data,
    }) => 
        GetOrderAdminResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetOrderAdminResponse.fromJson(Map<String, dynamic> json) => GetOrderAdminResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<OrderAdmin>.from(json["data"].map((x) => OrderAdmin.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class OrderAdmin {
    final String id;
    final String userId;
    final String status;
    final String orderCode;
    final int totalPrice;
    final DateTime createdAt;
    final DateTime updatedAt;
    final User user;
    final List<TransactionProduct> transactionProduct;

    OrderAdmin({
        required this.id,
        required this.userId,
        required this.status,
        required this.orderCode,
        required this.totalPrice,
        required this.createdAt,
        required this.updatedAt,
        required this.user,
        required this.transactionProduct,
    });

    OrderAdmin copyWith({
        String? id,
        String? userId,
        String? status,
        String? orderCode,
        int? totalPrice,
        DateTime? createdAt,
        DateTime? updatedAt,
        User? user,
        List<TransactionProduct>? transactionProduct,
    }) => 
        OrderAdmin(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            status: status ?? this.status,
            orderCode: orderCode ?? this.orderCode,
            totalPrice: totalPrice ?? this.totalPrice,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            user: user ?? this.user,
            transactionProduct: transactionProduct ?? this.transactionProduct,
        );

    factory OrderAdmin.fromJson(Map<String, dynamic> json) => OrderAdmin(
        id: json["id"],
        userId: json["userId"],
        status: json["status"],
        orderCode: json["orderCode"],
        totalPrice: json["totalPrice"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: User.fromJson(json["user"]),
        transactionProduct: List<TransactionProduct>.from(json["TransactionProduct"].map((x) => TransactionProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "status": status,
        "orderCode": orderCode,
        "totalPrice": totalPrice,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "TransactionProduct": List<dynamic>.from(transactionProduct.map((x) => x.toJson())),
    };
}

class TransactionProduct {
    final String id;
    final String transactionId;
    final String productId;
    final int quantity;
    final int price;
    final DateTime createdAt;
    final Product product;

    TransactionProduct({
        required this.id,
        required this.transactionId,
        required this.productId,
        required this.quantity,
        required this.price,
        required this.createdAt,
        required this.product,
    });

    TransactionProduct copyWith({
        String? id,
        String? transactionId,
        String? productId,
        int? quantity,
        int? price,
        DateTime? createdAt,
        Product? product,
    }) => 
        TransactionProduct(
            id: id ?? this.id,
            transactionId: transactionId ?? this.transactionId,
            productId: productId ?? this.productId,
            quantity: quantity ?? this.quantity,
            price: price ?? this.price,
            createdAt: createdAt ?? this.createdAt,
            product: product ?? this.product,
        );

    factory TransactionProduct.fromJson(Map<String, dynamic> json) => TransactionProduct(
        id: json["id"],
        transactionId: json["transactionId"],
        productId: json["productId"],
        quantity: json["quantity"],
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
        product: Product.fromJson(json["product"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "transactionId": transactionId,
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

class User {
    final String id;
    final String username;
    final String roleId;
    final Profile profile;

    User({
        required this.id,
        required this.username,
        required this.roleId,
        required this.profile,
    });

    User copyWith({
        String? id,
        String? username,
        String? roleId,
        Profile? profile,
    }) => 
        User(
            id: id ?? this.id,
            username: username ?? this.username,
            roleId: roleId ?? this.roleId,
            profile: profile ?? this.profile,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        roleId: json["roleId"],
        profile: Profile.fromJson(json["Profile"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "roleId": roleId,
        "Profile": profile.toJson(),
    };
}

class Profile {
    final String kdUser;
    final String name;
    final String telp;
    final String identityType;
    final String identityNumber;
    final String address;

    Profile({
        required this.kdUser,
        required this.name,
        required this.telp,
        required this.identityType,
        required this.identityNumber,
        required this.address,
    });

    Profile copyWith({
        String? kdUser,
        String? name,
        String? telp,
        String? identityType,
        String? identityNumber,
        String? address,
    }) => 
        Profile(
            kdUser: kdUser ?? this.kdUser,
            name: name ?? this.name,
            telp: telp ?? this.telp,
            identityType: identityType ?? this.identityType,
            identityNumber: identityNumber ?? this.identityNumber,
            address: address ?? this.address,
        );

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        kdUser: json["kd_User"],
        name: json["name"],
        telp: json["telp"],
        identityType: json["identityType"],
        identityNumber: json["identityNumber"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "kd_User": kdUser,
        "name": name,
        "telp": telp,
        "identityType": identityType,
        "identityNumber": identityNumber,
        "address": address,
    };
}
