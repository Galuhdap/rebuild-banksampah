// To parse this JSON data, do
//
//     final getTrashResponse = getTrashResponseFromJson(jsonString);

import 'dart:convert';

GetTrashResponse getTrashResponseFromJson(String str) =>
    GetTrashResponse.fromJson(json.decode(str));

String getTrashResponseToJson(GetTrashResponse data) =>
    json.encode(data.toJson());

class GetTrashResponse {
  final bool success;
  final int code;
  final String message;
  final List<GroupTrash> data;

  GetTrashResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  factory GetTrashResponse.fromJson(Map<String, dynamic> json) =>
      GetTrashResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<GroupTrash>.from(
            json["data"].map((x) => GroupTrash.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class GroupTrash {
  final String id;
  final String nama;
  num berat;
  final int harga;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  GroupTrash({
    required this.id,
    required this.nama,
    required this.berat,
    required this.harga,
    this.createdAt,
    this.updatedAt,
  });

  factory GroupTrash.fromJson(Map<String, dynamic> json) => GroupTrash(
        id: json["id"],
        nama: json["nama"],
        berat: json["berat"],
        harga: json["harga"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "berat": berat,
        "harga": harga,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
