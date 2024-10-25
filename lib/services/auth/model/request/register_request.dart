class RegisterRequest {
  String? username;
  String? password;
  String? identityType;
  String? role;
  String? identityNumber;
  String? name;
  String? address;
  String? telp;

  RegisterRequest({
    this.username,
    this.password,
    this.identityType,
    this.role,
    this.identityNumber,
    this.name,
    this.address,
    this.telp,
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
