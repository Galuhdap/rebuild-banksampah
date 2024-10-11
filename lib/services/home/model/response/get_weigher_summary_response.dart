// To parse this JSON data, do
//
//     final getWeigherSummaryResponse = getWeigherSummaryResponseFromJson(jsonString);

import 'dart:convert';

GetWeigherSummaryResponse getWeigherSummaryResponseFromJson(String str) => GetWeigherSummaryResponse.fromJson(json.decode(str));

String getWeigherSummaryResponseToJson(GetWeigherSummaryResponse data) => json.encode(data.toJson());

class GetWeigherSummaryResponse {
    final bool success;
    final int code;
    final String message;
    final SummaryWeigher data;

    GetWeigherSummaryResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetWeigherSummaryResponse copyWith({
        bool? success,
        int? code,
        String? message,
        SummaryWeigher? data,
    }) => 
        GetWeigherSummaryResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetWeigherSummaryResponse.fromJson(Map<String, dynamic> json) => GetWeigherSummaryResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: SummaryWeigher.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class SummaryWeigher {
    final num weight;
    final String kdUser;

    SummaryWeigher({
        required this.weight,
        required this.kdUser,
    });

    SummaryWeigher copyWith({
        num? weight,
        String? kdUser,
    }) => 
        SummaryWeigher(
            weight: weight ?? this.weight,
            kdUser: kdUser ?? this.kdUser,
        );

    factory SummaryWeigher.fromJson(Map<String, dynamic> json) => SummaryWeigher(
        weight: json["weight"],
        kdUser: json["kd_User"],
    );

    Map<String, dynamic> toJson() => {
        "weight": weight,
        "kd_User": kdUser,
    };
}
