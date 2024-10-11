// To parse this JSON data, do
//
//     final customerDepositTrashResponse = customerDepositTrashResponseFromJson(jsonString);

import 'dart:convert';

CustomerDepositTrashResponse customerDepositTrashResponseFromJson(String str) => CustomerDepositTrashResponse.fromJson(json.decode(str));

String customerDepositTrashResponseToJson(CustomerDepositTrashResponse data) => json.encode(data.toJson());

class CustomerDepositTrashResponse {
    final bool success;
    final int code;
    final String message;
    final List<Customer> data;

    CustomerDepositTrashResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    CustomerDepositTrashResponse copyWith({
        bool? success,
        int? code,
        String? message,
        List<Customer>? data,
    }) => 
        CustomerDepositTrashResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory CustomerDepositTrashResponse.fromJson(Map<String, dynamic> json) => CustomerDepositTrashResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<Customer>.from(json["data"].map((x) => Customer.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Customer {
    final String id;
    final String username;
    final Profile profile;

    Customer({
        required this.id,
        required this.username,
        required this.profile,
    });

    Customer copyWith({
        String? id,
        String? username,
        Profile? profile,
    }) => 
        Customer(
            id: id ?? this.id,
            username: username ?? this.username,
            profile: profile ?? this.profile,
        );

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        username: json["username"],
        profile: Profile.fromJson(json["Profile"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "Profile": profile.toJson(),
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
