// To parse this JSON data, do
//
//     final postTrashResponse = postTrashResponseFromJson(jsonString);

import 'dart:convert';

PostTrashResponse postTrashResponseFromJson(String str) => PostTrashResponse.fromJson(json.decode(str));

String postTrashResponseToJson(PostTrashResponse data) => json.encode(data.toJson());

class PostTrashResponse {
    final bool success;
    final int code;
    final String message;
    final TrashData data;

    PostTrashResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    PostTrashResponse copyWith({
        bool? success,
        int? code,
        String? message,
        TrashData? data,
    }) => 
        PostTrashResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory PostTrashResponse.fromJson(Map<String, dynamic> json) => PostTrashResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: TrashData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class TrashData {
    final String id;
    final String nama;
    final num berat;
    final int harga;
    final DateTime createdAt;
    final DateTime updatedAt;

    TrashData({
        required this.id,
        required this.nama,
        required this.berat,
        required this.harga,
        required this.createdAt,
        required this.updatedAt,
    });

    TrashData copyWith({
        String? id,
        String? nama,
        num? berat,
        int? harga,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        TrashData(
            id: id ?? this.id,
            nama: nama ?? this.nama,
            berat: berat ?? this.berat,
            harga: harga ?? this.harga,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory TrashData.fromJson(Map<String, dynamic> json) => TrashData(
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
