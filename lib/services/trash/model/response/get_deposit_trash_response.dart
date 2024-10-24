// To parse this JSON data, do
//
//     final depositTrashResponse = depositTrashResponseFromJson(jsonString);

import 'dart:convert';

DepositTrashResponse depositTrashResponseFromJson(String str) =>
    DepositTrashResponse.fromJson(json.decode(str));

String depositTrashResponseToJson(DepositTrashResponse data) =>
    json.encode(data.toJson());

class DepositTrashResponse {
  final bool success;
  final int code;
  final String message;
  final List<DepositTrash> data;

  DepositTrashResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  DepositTrashResponse copyWith({
    bool? success,
    int? code,
    String? message,
    List<DepositTrash>? data,
  }) =>
      DepositTrashResponse(
        success: success ?? this.success,
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory DepositTrashResponse.fromJson(Map<String, dynamic> json) =>
      DepositTrashResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<DepositTrash>.from(
            json["data"].map((x) => DepositTrash.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DepositTrash {
  final String summaryId;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final User user;
  final List<Deposit> deposits;

  DepositTrash({
    required this.summaryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.deposits,
  });

  DepositTrash copyWith({
    String? summaryId,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? user,
    List<Deposit>? deposits,
  }) =>
      DepositTrash(
        summaryId: summaryId ?? this.summaryId,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
        deposits: deposits ?? this.deposits,
      );

  factory DepositTrash.fromJson(Map<String, dynamic> json) => DepositTrash(
        summaryId: json["summaryId"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        user: User.fromJson(json["user"]),
        deposits: List<Deposit>.from(
            json["deposits"].map((x) => Deposit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "summaryId": summaryId,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "user": user.toJson(),
        "deposits": List<dynamic>.from(deposits.map((x) => x.toJson())),
      };
}

class Deposit {
  final String id;
  final String userId;
  final String trashId;
  final num weight;
  final int nominal;
  final String dataRaw;
  final DateTime createdAt;
  final DateTime updatedAt;

  Deposit({
    required this.id,
    required this.userId,
    required this.trashId,
    required this.weight,
    required this.nominal,
    required this.dataRaw,
    required this.createdAt,
    required this.updatedAt,
  });

  Deposit copyWith({
    String? id,
    String? userId,
    String? trashId,
    int? weight,
    int? nominal,
    String? dataRaw,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Deposit(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        trashId: trashId ?? this.trashId,
        weight: weight ?? this.weight,
        nominal: nominal ?? this.nominal,
        dataRaw: dataRaw ?? this.dataRaw,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        id: json["id"],
        userId: json["userId"],
        trashId: json["trashId"],
        weight: json["weight"],
        nominal: json["nominal"],
        dataRaw: json["dataRaw"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "trashId": trashId,
        "weight": weight,
        "nominal": nominal,
        "dataRaw": dataRaw,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class User {
  final String id;
  final String username;
  final Profile profile;

  User({
    required this.id,
    required this.username,
    required this.profile,
  });

  User copyWith({
    String? id,
    String? username,
    Profile? profile,
  }) =>
      User(
        id: id ?? this.id,
        username: username ?? this.username,
        profile: profile ?? this.profile,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        username: json["username"],
        profile: Profile.fromJson(json["profile"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "profile": profile.toJson(),
      };
}

class Profile {
  final String kdUser;
  final String address;
  final String name;

  Profile({
    required this.kdUser,
    required this.address,
    required this.name,
  });

  Profile copyWith({
    String? kdUser,
    String? address,
    String? name,
  }) =>
      Profile(
        kdUser: kdUser ?? this.kdUser,
        address: address ?? this.address,
        name: name ?? this.name,
      );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        kdUser: json["kd_user"],
        address: json["address"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "kd_user": kdUser,
        "address": address,
        "name": name,
      };
}
