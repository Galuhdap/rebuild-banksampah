

class DepositTrashRequest {
  final String userId;
  final String trashId;
  final num weight;

  DepositTrashRequest({
    required this.userId,
    required this.trashId,
    required this.weight,
  });

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "trashId": trashId,
        "weight": weight,
      };
}
