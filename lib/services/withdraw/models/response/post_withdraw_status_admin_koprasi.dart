// To parse this JSON data, do
//
//     final postWithdrawResponse = postWithdrawResponseFromJson(jsonString);

import 'dart:convert';

PostWithdrawResponse postWithdrawResponseFromJson(String str) => PostWithdrawResponse.fromJson(json.decode(str));

String postWithdrawResponseToJson(PostWithdrawResponse data) => json.encode(data.toJson());

class PostWithdrawResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    PostWithdrawResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    PostWithdrawResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        PostWithdrawResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PostWithdrawResponse.fromJson(Map<String, dynamic> json) => PostWithdrawResponse(
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
    final String status;
    final num balanceTrash;
    final int adminBalance;

    Data({
        required this.status,
        required this.balanceTrash,
        required this.adminBalance,
    });

    Data copyWith({
        String? status,
        num? balanceTrash,
        int? adminBalance,
    }) => 
        Data(
            status: status ?? this.status,
            balanceTrash: balanceTrash ?? this.balanceTrash,
            adminBalance: adminBalance ?? this.adminBalance,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        balanceTrash: json["balanceTrash"],
        adminBalance: json["adminBalance"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "balanceTrash": balanceTrash,
        "adminBalance": adminBalance,
    };
}
