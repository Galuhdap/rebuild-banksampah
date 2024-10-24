// To parse this JSON data, do
//
//     final postDepositTrashRequest = postDepositTrashRequestFromJson(jsonString);

import 'dart:convert';

PostDepositTrashRequest postDepositTrashRequestFromJson(String str) => PostDepositTrashRequest.fromJson(json.decode(str));

String postDepositTrashRequestToJson(PostDepositTrashRequest data) => json.encode(data.toJson());

class PostDepositTrashRequest {
    final String userId;
    final List<ItemTrsah> ItemTrsahs;

    PostDepositTrashRequest({
        required this.userId,
        required this.ItemTrsahs,
    });

    PostDepositTrashRequest copyWith({
        String? userId,
        List<ItemTrsah>? ItemTrsahs,
    }) => 
        PostDepositTrashRequest(
            userId: userId ?? this.userId,
            ItemTrsahs: ItemTrsahs ?? this.ItemTrsahs,
        );

    factory PostDepositTrashRequest.fromJson(Map<String, dynamic> json) => PostDepositTrashRequest(
        userId: json["userId"],
        ItemTrsahs: List<ItemTrsah>.from(json["ItemTrsahs"].map((x) => ItemTrsah.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "ItemTrsahs": List<dynamic>.from(ItemTrsahs.map((x) => x.toJson())),
    };
}

class ItemTrsah {
    final String trashId;
    final num weight;

    ItemTrsah({
        required this.trashId,
        required this.weight,
    });

    ItemTrsah copyWith({
        String? trashId,
        num? weight,
    }) => 
        ItemTrsah(
            trashId: trashId ?? this.trashId,
            weight: weight ?? this.weight,
        );

    factory ItemTrsah.fromJson(Map<String, dynamic> json) => ItemTrsah(
        trashId: json["trashId"],
        weight: json["weight"],
    );

    Map<String, dynamic> toJson() => {
        "trashId": trashId,
        "weight": weight,
    };
}
