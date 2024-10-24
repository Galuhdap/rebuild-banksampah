// To parse this JSON data, do
//
//     final deleteUserResponse = deleteUserResponseFromJson(jsonString);

import 'dart:convert';

DeleteUserResponse deleteUserResponseFromJson(String str) => DeleteUserResponse.fromJson(json.decode(str));

String deleteUserResponseToJson(DeleteUserResponse data) => json.encode(data.toJson());

class DeleteUserResponse {
    final bool success;
    final int code;
    final String message;

    DeleteUserResponse({
        required this.success,
        required this.code,
        required this.message,
    });

    DeleteUserResponse copyWith({
        bool? success,
        int? code,
        String? message,
    }) => 
        DeleteUserResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
        );

    factory DeleteUserResponse.fromJson(Map<String, dynamic> json) => DeleteUserResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
    };
}
