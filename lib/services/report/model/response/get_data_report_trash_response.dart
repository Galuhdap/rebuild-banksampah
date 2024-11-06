// To parse this JSON data, do
//
//     final getDataReportTrashResponse = getDataReportTrashResponseFromJson(jsonString);

import 'dart:convert';

GetDataReportTrashResponse getDataReportTrashResponseFromJson(String str) =>
    GetDataReportTrashResponse.fromJson(json.decode(str));

String getDataReportTrashResponseToJson(GetDataReportTrashResponse data) =>
    json.encode(data.toJson());

class GetDataReportTrashResponse {
  final bool success;
  final int code;
  final String message;
  final List<DataReportTrash> data;

  GetDataReportTrashResponse({
    required this.success,
    required this.code,
    required this.message,
    required this.data,
  });

  GetDataReportTrashResponse copyWith({
    bool? success,
    int? code,
    String? message,
    List<DataReportTrash>? data,
  }) =>
      GetDataReportTrashResponse(
        success: success ?? this.success,
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data,
      );

  factory GetDataReportTrashResponse.fromJson(Map<String, dynamic> json) =>
      GetDataReportTrashResponse(
        success: json["success"],
        code: json["code"],
        message: json["message"],
        data: List<DataReportTrash>.from(json["data"].map((x) => DataReportTrash.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataReportTrash {
  final String trashId;
  final String trashName;
  final num totalWeight;
  final List<Deposit> deposits;

  DataReportTrash({
    required this.trashId,
    required this.trashName,
    required this.totalWeight,
    required this.deposits,
  });

  DataReportTrash copyWith({
    String? trashId,
    String? trashName,
    num? totalWeight,
    List<Deposit>? deposits,
  }) =>
      DataReportTrash(
        trashId: trashId ?? this.trashId,
        trashName: trashName ?? this.trashName,
        totalWeight: totalWeight ?? this.totalWeight,
        deposits: deposits ?? this.deposits,
      );

  factory DataReportTrash.fromJson(Map<String, dynamic> json) => DataReportTrash(
        trashId: json["trashId"],
        trashName: json["trashName"],
        totalWeight: json["totalWeight"],
        deposits: List<Deposit>.from(
            json["deposits"].map((x) => Deposit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "trashId": trashId,
        "trashName": trashName,
        "totalWeight": totalWeight,
        "deposits": List<dynamic>.from(deposits.map((x) => x.toJson())),
      };
}

class Deposit {
  final num weight;
  final String customer;
  final String createdAt;

  Deposit({
    required this.weight,
    required this.customer,
    required this.createdAt,
  });

  Deposit copyWith({
    num? weight,
    String? customer,
    String? createdAt,
  }) =>
      Deposit(
        weight: weight ?? this.weight,
        customer: customer ?? this.customer,
        createdAt: createdAt ?? this.createdAt,
      );

  factory Deposit.fromJson(Map<String, dynamic> json) => Deposit(
        weight: json["weight"],
        customer: json["customer"],
        createdAt: json["createdAt"],
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "customer": customer,
        "createdAt": createdAt,
      };
}
