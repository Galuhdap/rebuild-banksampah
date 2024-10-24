class RegisterRequest {
  String username;
  String password;
  String identityType;
  String role;
  String identityNumber;
  String name;
  String address;
  String telp;

  RegisterRequest({
    required this.username,
    required this.password,
    required this.identityType,
    required this.role,
    required this.identityNumber,
    required this.name,
    required this.address,
    required this.telp,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "identityType": identityType,
        "role": role,
        "identityNumber": identityNumber,
        "name": name,
        "address": address,
        "telp": telp,
      };
}
