// To parse this JSON data, do
//
//     final getUpdateCustomerResponse = getUpdateCustomerResponseFromJson(jsonString);

import 'dart:convert';

GetUpdateCustomerResponse getUpdateCustomerResponseFromJson(String str) => GetUpdateCustomerResponse.fromJson(json.decode(str));

String getUpdateCustomerResponseToJson(GetUpdateCustomerResponse data) => json.encode(data.toJson());

class GetUpdateCustomerResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    GetUpdateCustomerResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetUpdateCustomerResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        GetUpdateCustomerResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetUpdateCustomerResponse.fromJson(Map<String, dynamic> json) => GetUpdateCustomerResponse(
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
    final String username;
    final String password;
    final String roleId;

    Data({
        required this.id,
        required this.username,
        required this.password,
        required this.roleId,
    });

    Data copyWith({
        String? id,
        String? username,
        String? password,
        String? roleId,
    }) => 
        Data(
            id: id ?? this.id,
            username: username ?? this.username,
            password: password ?? this.password,
            roleId: roleId ?? this.roleId,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        roleId: json["roleId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "roleId": roleId,
    };
}
