// To parse this JSON data, do
//
//     final postProductBuyRequest = postProductBuyRequestFromJson(jsonString);

import 'dart:convert';

PostUpdateStatusWithdrawRequest postUpdateStatusWithdrawRequest(String str) => PostUpdateStatusWithdrawRequest.fromJson(json.decode(str));

String postUpdateStatusWithdrawRequestToJson(PostUpdateStatusWithdrawRequest data) => json.encode(data.toJson());

class PostUpdateStatusWithdrawRequest {
    final String id;
    final String status;
  
    PostUpdateStatusWithdrawRequest({
        required this.id,
        required this.status,
    });

    PostUpdateStatusWithdrawRequest copyWith({
        String? id,
        String? status,
      
    }) => 
        PostUpdateStatusWithdrawRequest(
            id: id ?? this.id,
            status: status ?? this.status,
           
        );

    factory PostUpdateStatusWithdrawRequest.fromJson(Map<String, dynamic> json) => PostUpdateStatusWithdrawRequest(
        id: json["id"],
        status: json["status"],
       
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
       
    };
}
