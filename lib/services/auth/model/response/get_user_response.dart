// To parse this JSON data, do
//
//     final getUserResponse = getUserResponseFromJson(jsonString);

import 'dart:convert';

GetUserResponse getUserResponseFromJson(String str) => GetUserResponse.fromJson(json.decode(str));

String getUserResponseToJson(GetUserResponse data) => json.encode(data.toJson());

class GetUserResponse {
    final bool success;
    final int code;
    final String message;
    final List<UserData> data;

    GetUserResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetUserResponse copyWith({
        bool? success,
        int? code,
        String? message,
        List<UserData>? data,
    }) => 
        GetUserResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetUserResponse.fromJson(Map<String, dynamic> json) => GetUserResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<UserData>.from(json["data"].map((x) => UserData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class UserData {
    final String id;
    final String username;
    final String status;
    final Profile profile;
    final Role role;

    UserData({
        required this.id,
        required this.username,
        required this.status,
        required this.profile,
        required this.role,
    });

    UserData copyWith({
        String? id,
        String? username,
        String? status,
        Profile? profile,
        Role? role,
    }) => 
        UserData(
            id: id ?? this.id,
            username: username ?? this.username,
            status: status ?? this.status,
            profile: profile ?? this.profile,
            role: role ?? this.role,
        );

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        username: json["username"],
        status: json["status"],
        profile: Profile.fromJson(json["Profile"]),
        role: Role.fromJson(json["role"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "status": status,
        "Profile": profile.toJson(),
        "role": role.toJson(),
    };
}

class Profile {
    final String kdUser;
    final String name;
    final String telp;
    final String identityNumber;
    final String address;

    Profile({
        required this.kdUser,
        required this.name,
        required this.telp,
        required this.identityNumber,
        required this.address,
    });

    Profile copyWith({
        String? kdUser,
        String? name,
        String? telp,
        String? identityNumber,
        String? address,
    }) => 
        Profile(
            kdUser: kdUser ?? this.kdUser,
            name: name ?? this.name,
            telp: telp ?? this.telp,
            identityNumber: identityNumber ?? this.identityNumber,
            address: address ?? this.address,
        );

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        kdUser: json["kd_User"],
        name: json["name"],
        telp: json["telp"],
        identityNumber: json["identityNumber"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "kd_User": kdUser,
        "name": name,
        "telp": telp,
        "identityNumber": identityNumber,
        "address": address,
    };
}

class Role {
    final String name;

    Role({
        required this.name,
    });

    Role copyWith({
        String? name,
    }) => 
        Role(
            name: name ?? this.name,
        );

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}
