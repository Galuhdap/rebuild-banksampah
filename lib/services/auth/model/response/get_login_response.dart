// To parse this JSON data, do
//
//     final getLoginResponse = getLoginResponseFromJson(jsonString);

import 'dart:convert';

GetLoginResponse getLoginResponseFromJson(String str) => GetLoginResponse.fromJson(json.decode(str));

String getLoginResponseToJson(GetLoginResponse data) => json.encode(data.toJson());

class GetLoginResponse {
    bool success;
    int code;
    String message;
    Data data;

    GetLoginResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    factory GetLoginResponse.fromJson(Map<String, dynamic> json) => GetLoginResponse(
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
    String accessToken;

    Data({
        required this.accessToken,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        accessToken: json["accessToken"],
    );

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
    };
}
