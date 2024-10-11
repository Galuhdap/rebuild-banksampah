// To parse this JSON data, do
//
//     final postDepositTrashResponse = postDepositTrashResponseFromJson(jsonString);

import 'dart:convert';

PostDepositTrashResponse postDepositTrashResponseFromJson(String str) => PostDepositTrashResponse.fromJson(json.decode(str));

String postDepositTrashResponseToJson(PostDepositTrashResponse data) => json.encode(data.toJson());

class PostDepositTrashResponse {
    final bool success;
    final int code;
    final String message;
    final BalanceTrash data;

    PostDepositTrashResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    PostDepositTrashResponse copyWith({
        bool? success,
        int? code,
        String? message,
        BalanceTrash? data,
    }) => 
        PostDepositTrashResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PostDepositTrashResponse.fromJson(Map<String, dynamic> json) => PostDepositTrashResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: BalanceTrash.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class BalanceTrash {
    final int updatedBalance;
    final Deposit deposit;

    BalanceTrash({
        required this.updatedBalance,
        required this.deposit,
    });

    BalanceTrash copyWith({
        int? updatedBalance,
        Deposit? deposit,
    }) => 
        BalanceTrash(
            updatedBalance: updatedBalance ?? this.updatedBalance,
            deposit: deposit ?? this.deposit,
        );

    factory BalanceTrash.fromJson(Map<String, dynamic> json) => BalanceTrash(
        updatedBalance: json["updatedBalance"],
        deposit: Deposit.fromJson(json["deposit"]),
    );

    Map<String, dynamic> toJson() => {
        "updatedBalance": updatedBalance,
        "deposit": deposit.toJson(),
    };
}

class Deposit {
    final String id;
    final String userId;
    final String trashId;
    final double weight;
    final int nominal;
    final String dataRaw;
    final DateTime createdAt;
    final DateTime updatedAt;

    Deposit({
        required this.id,
        required this.userId,
        required this.trashId,
        required this.weight,
        required this.nominal,
        required this.dataRaw,
        required this.createdAt,
        required this.updatedAt,
    });

    Deposit copyWith({
        String? id,
        String? userId,
        String? trashId,
        double? weight,
        int? nominal,
        String? dataRaw,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Deposit(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            trashId: trashId ?? this.trashId,
            weight: weight ?? this.weight,
            nominal: nominal ?? this.nominal,
            dataRaw: dataRaw ?? this.dataRaw,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        id: json["id"],
        userId: json["userId"],
        trashId: json["trashId"],
        weight: json["weight"]?.toDouble(),
        nominal: json["nominal"],
        dataRaw: json["dataRaw"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "trashId": trashId,
        "weight": weight,
        "nominal": nominal,
        "dataRaw": dataRaw,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
