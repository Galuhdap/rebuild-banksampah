// To parse this JSON data, do
//
//     final deletePriceTrashResponse = deletePriceTrashResponseFromJson(jsonString);

import 'dart:convert';

DeletePriceTrashResponse deletePriceTrashResponseFromJson(String str) => DeletePriceTrashResponse.fromJson(json.decode(str));

String deletePriceTrashResponseToJson(DeletePriceTrashResponse data) => json.encode(data.toJson());

class DeletePriceTrashResponse {
    final bool success;
    final int code;
    final String message;

    DeletePriceTrashResponse({
        required this.success,
        required this.code,
        required this.message,
    });

    DeletePriceTrashResponse copyWith({
        bool? success,
        int? code,
        String? message,
    }) => 
        DeletePriceTrashResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
        );

    factory DeletePriceTrashResponse.fromJson(Map<String, dynamic> json) => DeletePriceTrashResponse(
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
