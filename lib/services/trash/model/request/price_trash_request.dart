class PriceTrashRequest {
  final String name;
  final int price;
  final num weight;

  PriceTrashRequest ({
    required this.name,
    required this.price,
    required this.weight,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "weight": weight,
      };
}