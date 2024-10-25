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
    final String id;
    final String nameAdmin;
    final String nameCoop;
    final int nominal;
    final String status;
    final DateTime createdAt;
    final DateTime updatedAt;

    Data({
        required this.id,
        required this.nameAdmin,
        required this.nameCoop,
        required this.nominal,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    Data copyWith({
        String? id,
        String? nameAdmin,
        String? nameCoop,
        int? nominal,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Data(
            id: id ?? this.id,
            nameAdmin: nameAdmin ?? this.nameAdmin,
            nameCoop: nameCoop ?? this.nameCoop,
            nominal: nominal ?? this.nominal,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        nameAdmin: json["name_admin"],
        nameCoop: json["name_coop"],
        nominal: json["nominal"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_admin": nameAdmin,
        "name_coop": nameCoop,
        "nominal": nominal,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
