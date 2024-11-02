// To parse this JSON data, do
//
//     final getChartCommodityDailyResponse = getChartCommodityDailyResponseFromJson(jsonString);

import 'dart:convert';

GetChartCommodityDailyResponse getChartCommodityDailyResponseFromJson(String str) => GetChartCommodityDailyResponse.fromJson(json.decode(str));

String GetChartCommodityDailyResponseToJson(GetChartCommodityDailyResponse data) => json.encode(data.toJson());

class GetChartCommodityDailyResponse {
    int status;
    String message;
    ChartData data;

    GetChartCommodityDailyResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetChartCommodityDailyResponse.fromJson(Map<String, dynamic> json) => GetChartCommodityDailyResponse(
        status: json["status"],
        message: json["message"],
        data: ChartData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class ChartData {
    List<DataDaily> data;
    int total;

    ChartData({
        required this.data,
        required this.total,
    });

    factory ChartData.fromJson(Map<String, dynamic> json) => ChartData(
        data: List<DataDaily>.from(json["data"].map((x) => DataDaily.fromJson(x))),
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
    };
}

class DataDaily {
    int value;
    DateTime time;

    DataDaily({
        required this.value,
        required this.time,
    });

    factory DataDaily.fromJson(Map<String, dynamic> json) => DataDaily(
        value: json["value"],
        time: DateTime.parse(json["time"]),
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "time": "${time.year.toString().padLeft(4, '0')}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}",
    };
}