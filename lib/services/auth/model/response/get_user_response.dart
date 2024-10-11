// To parse this JSON data, do
//
//     final posUserResponse = posUserResponseFromJson(jsonString);

import 'dart:convert';

PosUserResponse posUserResponseFromJson(String str) => PosUserResponse.fromJson(json.decode(str));

String posUserResponseToJson(PosUserResponse data) => json.encode(data.toJson());

class PosUserResponse {
    final bool success;
    final int code;
    final String message;
    final List<UserData> data;

    PosUserResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    PosUserResponse copyWith({
        bool? success,
        int? code,
        String? message,
        List<UserData>? data,
    }) => 
        PosUserResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PosUserResponse.fromJson(Map<String, dynamic> json) => PosUserResponse(
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
    final Profile profile;
    final Role role;

    UserData({
        required this.id,
        required this.username,
        required this.profile,
        required this.role,
    });

    UserData copyWith({
        String? id,
        String? username,
        Profile? profile,
        Role? role,
    }) => 
        UserData(
            id: id ?? this.id,
            username: username ?? this.username,
            profile: profile ?? this.profile,
            role: role ?? this.role,
        );

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json["id"],
        username: json["username"],
        profile: Profile.fromJson(json["Profile"]),
        role: Role.fromJson(json["role"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "Profile": profile.toJson(),
        "role": role.toJson(),
    };
}

class Profile {
    final String kdUser;
    final String name;

    Profile({
        required this.kdUser,
        required this.name,
    });

    Profile copyWith({
        String? kdUser,
        String? name,
    }) => 
        Profile(
            kdUser: kdUser ?? this.kdUser,
            name: name ?? this.name,
        );

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        kdUser: json["kd_User"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "kd_User": kdUser,
        "name": name,
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
