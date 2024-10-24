// To parse this JSON data, do
//
//     final getProfileResponse = getProfileResponseFromJson(jsonString);

import 'dart:convert';

GetProfileResponse getProfileResponseFromJson(String str) => GetProfileResponse.fromJson(json.decode(str));

String getProfileResponseToJson(GetProfileResponse data) => json.encode(data.toJson());

class GetProfileResponse {
    final bool success;
    final int code;
    final String message;
    final ProfileData data;

    GetProfileResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetProfileResponse copyWith({
        bool? success,
        int? code,
        String? message,
        ProfileData? data,
    }) => 
        GetProfileResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetProfileResponse.fromJson(Map<String, dynamic> json) => GetProfileResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: ProfileData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class ProfileData {
    final String id;
    final String userId;
    final String identityType;
    final String telp;
    final String identityNumber;
    final String name;
    final String address;

    ProfileData({
        required this.id,
        required this.userId,
        required this.identityType,
        required this.telp,
        required this.identityNumber,
        required this.name,
        required this.address,
    });

    ProfileData copyWith({
        String? id,
        String? userId,
        String? identityType,
        String? telp,
        String? identityNumber,
        String? name,
        String? address,
    }) => 
        ProfileData(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            identityType: identityType ?? this.identityType,
            telp: telp ?? this.telp,
            identityNumber: identityNumber ?? this.identityNumber,
            name: name ?? this.name,
            address: address ?? this.address,
        );

    factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json["id"],
        userId: json["userId"],
        identityType: json["identityType"],
        telp: json["telp"],
        identityNumber: json["identityNumber"],
        name: json["name"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "identityType": identityType,
        "telp": telp,
        "identityNumber": identityNumber,
        "name": name,
        "address": address,
    };
}
