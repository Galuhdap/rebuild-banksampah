// To parse this JSON data, do
//
//     final getOrderAdminStatusResponse = getOrderAdminStatusResponseFromJson(jsonString);

import 'dart:convert';

GetOrderAdminStatusResponse getOrderAdminStatusResponseFromJson(String str) => GetOrderAdminStatusResponse.fromJson(json.decode(str));

String getOrderAdminStatusResponseToJson(GetOrderAdminStatusResponse data) => json.encode(data.toJson());

class GetOrderAdminStatusResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    GetOrderAdminStatusResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetOrderAdminStatusResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        GetOrderAdminStatusResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetOrderAdminStatusResponse.fromJson(Map<String, dynamic> json) => GetOrderAdminStatusResponse(
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
    final UpdatedTransaction updatedTransaction;
    final UpdatedBalance updatedBalance;

    Data({
        required this.updatedTransaction,
        required this.updatedBalance,
    });

    Data copyWith({
        UpdatedTransaction? updatedTransaction,
        UpdatedBalance? updatedBalance,
    }) => 
        Data(
            updatedTransaction: updatedTransaction ?? this.updatedTransaction,
            updatedBalance: updatedBalance ?? this.updatedBalance,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        updatedTransaction: UpdatedTransaction.fromJson(json["updatedTransaction"]),
        updatedBalance: UpdatedBalance.fromJson(json["updatedBalance"]),
    );

    Map<String, dynamic> toJson() => {
        "updatedTransaction": updatedTransaction.toJson(),
        "updatedBalance": updatedBalance.toJson(),
    };
}

class UpdatedBalance {
    final String id;
    final String userId;
    final int balance;
    final DateTime createdAt;
    final DateTime updatedAt;

    UpdatedBalance({
        required this.id,
        required this.userId,
        required this.balance,
        required this.createdAt,
        required this.updatedAt,
    });

    UpdatedBalance copyWith({
        String? id,
        String? userId,
        int? balance,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        UpdatedBalance(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            balance: balance ?? this.balance,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory UpdatedBalance.fromJson(Map<String, dynamic> json) => UpdatedBalance(
        id: json["id"],
        userId: json["userId"],
        balance: json["balance"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "balance": balance,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}

class UpdatedTransaction {
    final String id;
    final String userId;
    final String status;
    final String orderCode;
    final DateTime createdAt;
    final DateTime updatedAt;
    final List<TransactionProduct> transactionProduct;

    UpdatedTransaction({
        required this.id,
        required this.userId,
        required this.status,
        required this.orderCode,
        required this.createdAt,
        required this.updatedAt,
        required this.transactionProduct,
    });

    UpdatedTransaction copyWith({
        String? id,
        String? userId,
        String? status,
        String? orderCode,
        DateTime? createdAt,
        DateTime? updatedAt,
        List<TransactionProduct>? transactionProduct,
    }) => 
        UpdatedTransaction(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            status: status ?? this.status,
            orderCode: orderCode ?? this.orderCode,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            transactionProduct: transactionProduct ?? this.transactionProduct,
        );

    factory UpdatedTransaction.fromJson(Map<String, dynamic> json) => UpdatedTransaction(
        id: json["id"],
        userId: json["userId"],
        status: json["status"],
        orderCode: json["orderCode"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        transactionProduct: List<TransactionProduct>.from(json["TransactionProduct"].map((x) => TransactionProduct.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "status": status,
        "orderCode": orderCode,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
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

    TransactionProduct({
        required this.id,
        required this.transactionId,
        required this.productId,
        required this.quantity,
        required this.price,
        required this.createdAt,
    });

    TransactionProduct copyWith({
        String? id,
        String? transactionId,
        String? productId,
        int? quantity,
        int? price,
        DateTime? createdAt,
    }) => 
        TransactionProduct(
            id: id ?? this.id,
            transactionId: transactionId ?? this.transactionId,
            productId: productId ?? this.productId,
            quantity: quantity ?? this.quantity,
            price: price ?? this.price,
            createdAt: createdAt ?? this.createdAt,
        );

    factory TransactionProduct.fromJson(Map<String, dynamic> json) => TransactionProduct(
        id: json["id"],
        transactionId: json["transactionId"],
        productId: json["productId"],
        quantity: json["quantity"],
        price: json["price"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "transactionId": transactionId,
        "productId": productId,
        "quantity": quantity,
        "price": price,
        "createdAt": createdAt.toIso8601String(),
    };
}
