// To parse this JSON data, do
//
//     final postProductBuyRequest = postProductBuyRequestFromJson(jsonString);

import 'dart:convert';

PostProductBuyRequest postProductBuyRequestFromJson(String str) => PostProductBuyRequest.fromJson(json.decode(str));

String postProductBuyRequestToJson(PostProductBuyRequest data) => json.encode(data.toJson());

class PostProductBuyRequest {
    final String userId;
    final List<ListProductDatum> listProductData;

    PostProductBuyRequest({
        required this.userId,
        required this.listProductData,
    });

    PostProductBuyRequest copyWith({
        String? userId,
        List<ListProductDatum>? listProductData,
    }) => 
        PostProductBuyRequest(
            userId: userId ?? this.userId,
            listProductData: listProductData ?? this.listProductData,
        );

    factory PostProductBuyRequest.fromJson(Map<String, dynamic> json) => PostProductBuyRequest(
        userId: json["userId"],
        listProductData: List<ListProductDatum>.from(json["ListProductData"].map((x) => ListProductDatum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "ListProductData": List<dynamic>.from(listProductData.map((x) => x.toJson())),
    };
}

class ListProductDatum {
    final String productId;
    final int quantity;

    ListProductDatum({
        required this.productId,
        required this.quantity,
    });

    ListProductDatum copyWith({
        String? productId,
        int? quantity,
    }) => 
        ListProductDatum(
            productId: productId ?? this.productId,
            quantity: quantity ?? this.quantity,
        );

    factory ListProductDatum.fromJson(Map<String, dynamic> json) => ListProductDatum(
        productId: json["productId"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "quantity": quantity,
    };
}
