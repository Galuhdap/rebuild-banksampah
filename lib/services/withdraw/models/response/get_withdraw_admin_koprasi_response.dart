// To parse this JSON data, do
//
//     final getWithdarawAdminKoprasiResponse = getWithdarawAdminKoprasiResponseFromJson(jsonString);

import 'dart:convert';

GetWithdarawAdminKoprasiResponse getWithdarawAdminKoprasiResponseFromJson(String str) => GetWithdarawAdminKoprasiResponse.fromJson(json.decode(str));

String getWithdarawAdminKoprasiResponseToJson(GetWithdarawAdminKoprasiResponse data) => json.encode(data.toJson());

class GetWithdarawAdminKoprasiResponse {
    final bool success;
    final int code;
    final String message;
    final List<DataWithdrawAdminKoprasi> data;

    GetWithdarawAdminKoprasiResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetWithdarawAdminKoprasiResponse copyWith({
        bool? success,
        int? code,
        String? message,
        List<DataWithdrawAdminKoprasi>? data,
    }) => 
        GetWithdarawAdminKoprasiResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetWithdarawAdminKoprasiResponse.fromJson(Map<String, dynamic> json) => GetWithdarawAdminKoprasiResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<DataWithdrawAdminKoprasi>.from(json["data"].map((x) => DataWithdrawAdminKoprasi.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class DataWithdrawAdminKoprasi {
    final String id;
    final String nameAdmin;
    final String nameCoop;
    final int nominal;
    final String status;
    final DateTime createdAt;
    final DateTime updatedAt;

    DataWithdrawAdminKoprasi({
        required this.id,
        required this.nameAdmin,
        required this.nameCoop,
        required this.nominal,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
    });

    DataWithdrawAdminKoprasi copyWith({
        String? id,
        String? nameAdmin,
        String? nameCoop,
        int? nominal,
        String? status,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        DataWithdrawAdminKoprasi(
            id: id ?? this.id,
            nameAdmin: nameAdmin ?? this.nameAdmin,
            nameCoop: nameCoop ?? this.nameCoop,
            nominal: nominal ?? this.nominal,
            status: status ?? this.status,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory DataWithdrawAdminKoprasi.fromJson(Map<String, dynamic> json) => DataWithdrawAdminKoprasi(
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
