// To parse this JSON data, do
//
//     final getBalanceAdminKoprasiResponse = getBalanceAdminKoprasiResponseFromJson(jsonString);

import 'dart:convert';

GetBalanceAdminKoprasiResponse getBalanceAdminKoprasiResponseFromJson(String str) => GetBalanceAdminKoprasiResponse.fromJson(json.decode(str));

String getBalanceAdminKoprasiResponseToJson(GetBalanceAdminKoprasiResponse data) => json.encode(data.toJson());

class GetBalanceAdminKoprasiResponse {
    final bool success;
    final int code;
    final String message;
    final SummaryAdminKoprasi data;

    GetBalanceAdminKoprasiResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetBalanceAdminKoprasiResponse copyWith({
        bool? success,
        int? code,
        String? message,
        SummaryAdminKoprasi? data,
    }) => 
        GetBalanceAdminKoprasiResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetBalanceAdminKoprasiResponse.fromJson(Map<String, dynamic> json) => GetBalanceAdminKoprasiResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: SummaryAdminKoprasi.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class SummaryAdminKoprasi {
    final int balance;

    SummaryAdminKoprasi({
        required this.balance,
    });

    SummaryAdminKoprasi copyWith({
        int? balance,
    }) => 
        SummaryAdminKoprasi(
            balance: balance ?? this.balance,
        );

    factory SummaryAdminKoprasi.fromJson(Map<String, dynamic> json) => SummaryAdminKoprasi(
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "balance": balance,
    };
}
