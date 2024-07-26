import 'dart:convert';

GetLoginResponse getLoginResponseFromJson(String str) => GetLoginResponse.fromJson(json.decode(str));

String getLoginResponseToJson(GetLoginResponse data) => json.encode(data.toJson());

class GetLoginResponse {
    int id;
    String username;
    String password;

    GetLoginResponse({
        required this.id,
        required this.username,
        required this.password,
    });

    factory GetLoginResponse.fromJson(Map<String, dynamic> json) => GetLoginResponse(
        id: json["id"],
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
    };
}