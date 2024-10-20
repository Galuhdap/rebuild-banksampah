// To parse this JSON data, do
//
//     final postProductBuyRequest = postProductBuyRequestFromJson(jsonString);

import 'dart:convert';

PostUpdateStatusRequest postUpdateStatusRequest(String str) => PostUpdateStatusRequest.fromJson(json.decode(str));

String postUpdateStatusRequestToJson(PostUpdateStatusRequest data) => json.encode(data.toJson());

class PostUpdateStatusRequest {
    final String transactionId;
    final String status;
  
    PostUpdateStatusRequest({
        required this.transactionId,
        required this.status,
    });

    PostUpdateStatusRequest copyWith({
        String? transactionId,
        String? status,
      
    }) => 
        PostUpdateStatusRequest(
            transactionId: transactionId ?? this.transactionId,
            status: status ?? this.status,
           
        );

    factory PostUpdateStatusRequest.fromJson(Map<String, dynamic> json) => PostUpdateStatusRequest(
        transactionId: json["transactionId"],
        status: json["status"],
       
    );

    Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "status": status,
       
    };
}
