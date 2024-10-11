// To parse this JSON data, do
//
//     final deleteDepositTrashResponse = deleteDepositTrashResponseFromJson(jsonString);

import 'dart:convert';

DeleteDepositTrashResponse deleteDepositTrashResponseFromJson(String str) => DeleteDepositTrashResponse.fromJson(json.decode(str));

String deleteDepositTrashResponseToJson(DeleteDepositTrashResponse data) => json.encode(data.toJson());

class DeleteDepositTrashResponse {
    final bool success;
    final int code;
    final String message;
    final Data data;

    DeleteDepositTrashResponse({
        required this.success,
        required this.code,
        required this.message,
        required this.data,
    });

    DeleteDepositTrashResponse copyWith({
        bool? success,
        int? code,
        String? message,
        Data? data,
    }) => 
        DeleteDepositTrashResponse(
            success: success ?? this.success,
            code: code ?? this.code,
            message: message ?? this.message,
            data: data ?? this.data,
        );

    factory DeleteDepositTrashResponse.fromJson(Map<String, dynamic> json) => DeleteDepositTrashResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    final int updatedBalance;
    final DeletedDeposit deletedDeposit;

    Data({
        required this.updatedBalance,
        required this.deletedDeposit,
    });

    Data copyWith({
        int? updatedBalance,
        DeletedDeposit? deletedDeposit,
    }) => 
        Data(
            updatedBalance: updatedBalance ?? this.updatedBalance,
            deletedDeposit: deletedDeposit ?? this.deletedDeposit,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        updatedBalance: json["updatedBalance"],
        deletedDeposit: DeletedDeposit.fromJson(json["deletedDeposit"]),
    );

    Map<String, dynamic> toJson() => {
        "updatedBalance": updatedBalance,
        "deletedDeposit": deletedDeposit.toJson(),
    };
}

class DeletedDeposit {
    final String id;
    final String userId;
    final String trashId;
    final int weight;
    final int nominal;
    final String dataRaw;
    final DateTime createdAt;
    final DateTime updatedAt;

    DeletedDeposit({
        required this.id,
        required this.userId,
        required this.trashId,
        required this.weight,
        required this.nominal,
        required this.dataRaw,
        required this.createdAt,
        required this.updatedAt,
    });

    DeletedDeposit copyWith({
        String? id,
        String? userId,
        String? trashId,
        int? weight,
        int? nominal,
        String? dataRaw,
        DateTime? createdAt,
        DateTime? updatedAt,
    }) => 
        DeletedDeposit(
            id: id ?? this.id,
            userId: userId ?? this.userId,
            trashId: trashId ?? this.trashId,
            weight: weight ?? this.weight,
            nominal: nominal ?? this.nominal,
            dataRaw: dataRaw ?? this.dataRaw,
            createdAt: createdAt ?? this.createdAt,
            updatedAt: updatedAt ?? this.updatedAt,
        );

    factory DeletedDeposit.fromJson(Map<String, dynamic> json) => DeletedDeposit(
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
