// To parse this JSON data, do
//
//     final getCustomerDepositTrashResponse = getCustomerDepositTrashResponseFromJson(jsonString);

import 'dart:convert';

GetCustomerDepositTrashResponse getCustomerDepositTrashResponseFromJson(String str) => GetCustomerDepositTrashResponse.fromJson(json.decode(str));

String getCustomerDepositTrashResponseToJson(GetCustomerDepositTrashResponse data) => json.encode(data.toJson());

class GetCustomerDepositTrashResponse {
    final bool success;
    final int code;
    final String message;
    final List<GetCustomerDeposit> data;

    GetCustomerDepositTrashResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    GetCustomerDepositTrashResponse copyWith({
        bool? success,
        int? code,
        String? message,
        List<GetCustomerDeposit>? data,
    }) => 
        GetCustomerDepositTrashResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory GetCustomerDepositTrashResponse.fromJson(Map<String, dynamic> json) => GetCustomerDepositTrashResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<GetCustomerDeposit>.from(json["data"].map((x) => GetCustomerDeposit.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class GetCustomerDeposit {
    final String id;
    final String userId;
    final String trashId;
    final num weight;
    final int nominal;
    final String dataRaw;
    final DateTime createdAt;
    final DateTime updatedAt;
    final Sampah sampah;

    GetCustomerDeposit({
        required this.id,
        required this.userId,
        required this.trashId,
        required this.weight,
        required this.nominal,
        required this.dataRaw,
        required this.createdAt,
        required this.updatedAt,
        required this.sampah,
    });

    GetCustomerDeposit copyWith({
        String? id,
        String? userId,
        String? trashId,
        num? weight,
        int? nominal,
        String? dataRaw,
        DateTime? createdAt,
        DateTime? updatedAt,
        Sampah? sampah,
    }) => 
        GetCustomerDeposit(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            trashId: trashId ?? this.trashId,
            weight: weight ?? this.weight,
            nominal: nominal ?? this.nominal,
            dataRaw: dataRaw ?? this.dataRaw,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
            sampah: sampah ?? this.sampah,
        );

    factory GetCustomerDeposit.fromJson(Map<String, dynamic> json) => GetCustomerDeposit(
        id: json["id"],
        userId: json["userId"],
        trashId: json["trashId"],
        weight: json["weight"],
        nominal: json["nominal"],
        dataRaw: json["dataRaw"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        sampah: Sampah.fromJson(json["Sampah"]),
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
        "Sampah": sampah.toJson(),
    };
}

class Sampah {
    final String id;
    final String nama;
    final int berat;
    final int harga;
    final DateTime createdAt;
    final DateTime updatedAt;

    Sampah({
        required this.id,
        required this.nama,
        required this.berat,
        required this.harga,
        required this.createdAt,
        required this.updatedAt,
    });

    Sampah copyWith({
        String? id,
        String? nama,
        int? berat,
        int? harga,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        Sampah(
            id: id ?? this.id,
            nama: nama ?? this.nama,
            berat: berat ?? this.berat,
            harga: harga ?? this.harga,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory Sampah.fromJson(Map<String, dynamic> json) => Sampah(
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
