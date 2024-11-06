// To parse this JSON data, do
//
//     final getChartRequest = getChartRequestFromJson(jsonString);

import 'dart:convert';

GetChartRequest getChartRequestFromJson(String str) =>
    GetChartRequest.fromJson(json.decode(str));

String getChartRequestToJson(GetChartRequest data) =>
    json.encode(data.toJson());

class GetChartRequest {
  String yearMonth;
  String trashId;

  GetChartRequest({
    required this.yearMonth,
    required this.trashId,
  });

  factory GetChartRequest.fromJson(Map<String, dynamic> json) =>
      GetChartRequest(
        yearMonth: json["yearMonth"],
        trashId: json["trashId"],
      );

  Map<String, dynamic> toJson() => {
        "yearMonth": yearMonth,
        "trashId": trashId,
      };
}
