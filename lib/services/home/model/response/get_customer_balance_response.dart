// To parse this JSON data, do
//
//     final getCustomerBalanceResponse = getCustomerBalanceResponseFromJson(jsonString);

import 'dart:convert';

GetCustomerBalanceResponse getCustomerBalanceResponseFromJson(String str) => GetCustomerBalanceResponse.fromJson(json.decode(str));

String getCustomerBalanceResponseToJson(GetCustomerBalanceResponse data) => json.encode(data.toJson());

class GetCustomerBalanceResponse {
    final bool success;
    final int code;
    final String message;
    final BalanceCustomer data;

    GetCustomerBalanceResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetCustomerBalanceResponse copyWith({
        bool? success,
        int? code,
        String? message,
        BalanceCustomer? data,
    }) => 
        GetCustomerBalanceResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetCustomerBalanceResponse.fromJson(Map<String, dynamic> json) => GetCustomerBalanceResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: BalanceCustomer.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class BalanceCustomer {
    final String id;
    final String userId;
    final int balance;
    final DateTime createdAt;
    final DateTime updatedAt;

    BalanceCustomer({
        required this.id,
        required this.userId,
        required this.balance,
        required this.createdAt,
        required this.updatedAt,
    });

    BalanceCustomer copyWith({
        String? id,
        String? userId,
        int? balance,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        BalanceCustomer(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            balance: balance ?? this.balance,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory BalanceCustomer.fromJson(Map<String, dynamic> json) => BalanceCustomer(
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
