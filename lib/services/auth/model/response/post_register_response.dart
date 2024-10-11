// To parse this JSON data, do
//
//     final postUserRegisterResponse = postUserRegisterResponseFromJson(jsonString);

import 'dart:convert';

PostUserRegisterResponse postUserRegisterResponseFromJson(String str) => PostUserRegisterResponse.fromJson(json.decode(str));

String postUserRegisterResponseToJson(PostUserRegisterResponse data) => json.encode(data.toJson());

class PostUserRegisterResponse {
    final bool success;
    final int code;
    final String message;
    final UserData data;

    PostUserRegisterResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    PostUserRegisterResponse copyWith({
        bool? success,
        int? code,
        String? message,
        UserData? data,
    }) => 
        PostUserRegisterResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PostUserRegisterResponse.fromJson(Map<String, dynamic> json) => PostUserRegisterResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: UserData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class UserData {
    final User user;

    UserData({
        required this.user,
    });

    UserData copyWith({
        User? user,
    }) => 
        UserData(
            user: user ?? this.user,
        );

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "user": user.toJson(),
    };
}

class User {
    final String username;
    final String role;
    final Profile profile;
    final int balance;

    User({
        required this.username,
        required this.role,
        required this.profile,
        required this.balance,
    });

    User copyWith({
        String? username,
        String? role,
        Profile? profile,
        int? balance,
    }) => 
        User(
            username: username ?? this.username,
            role: role ?? this.role,
            profile: profile ?? this.profile,
            balance: balance ?? this.balance,
        );

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        role: json["role"],
        profile: Profile.fromJson(json["profile"]),
        balance: json["balance"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "role": role,
        "profile": profile.toJson(),
        "balance": balance,
    };
}

class Profile {
    final String identityType;
    final String identityNumber;
    final String address;
    final String name;

    Profile({
        required this.identityType,
        required this.identityNumber,
        required this.address,
        required this.name,
    });

    Profile copyWith({
        String? identityType,
        String? identityNumber,
        String? address,
        String? name,
    }) => 
        Profile(
            identityType: identityType ?? this.identityType,
            identityNumber: identityNumber ?? this.identityNumber,
            address: address ?? this.address,
            name: name ?? this.name,
        );

    factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        identityType: json["identityType"],
        identityNumber: json["identityNumber"],
        address: json["address"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "identityType": identityType,
        "identityNumber": identityNumber,
        "address": address,
        "name": name,
    };
}
