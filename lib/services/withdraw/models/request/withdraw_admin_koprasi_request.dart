class WithdrawAdminKoprasiRequest {
  String nameAdmin;
  String nameCoop;
  int nominal;

  WithdrawAdminKoprasiRequest(
      {required this.nameAdmin, required this.nameCoop, required this.nominal});

  Map<String, String> toJson() => {
        "nameAdmin": nameAdmin,
        "nameCoop": nameCoop,
        "nominal": nominal.toString(),
      };
}
