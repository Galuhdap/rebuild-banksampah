// To parse this JSON data, do
//
//     final getDepositTrashUpdateResponse = getDepositTrashUpdateResponseFromJson(jsonString);

import 'dart:convert';

GetDepositTrashUpdateResponse getDepositTrashUpdateResponseFromJson(String str) => GetDepositTrashUpdateResponse.fromJson(json.decode(str));

String getDepositTrashUpdateResponseToJson(GetDepositTrashUpdateResponse data) => json.encode(data.toJson());

class GetDepositTrashUpdateResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    GetDepositTrashUpdateResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetDepositTrashUpdateResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        GetDepositTrashUpdateResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetDepositTrashUpdateResponse.fromJson(Map<String, dynamic> json) => GetDepositTrashUpdateResponse(
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
    final String id;
    final String status;
    final DateTime createdAt;
    final DateTime updatedAt;

    Data({
        required this.id,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    Data copyWith({
        String? id,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Data(
            id: id ?? this.id,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
