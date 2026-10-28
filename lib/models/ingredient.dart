class Ingredient {
  final int? quantity;
  final String? unit;
  final String name;

  Ingredient({required this.quantity, required this.unit, required this.name});

  factory Ingredient.fromJson(Map<String, dynamic> json) => Ingredient(
    quantity: json["quantity"],
    unit: json["unit"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "unit": unit,
    "name": name,
  };

  @override
  String toString() {
    if (quantity != null && unit != null) return "· $quantity $unit $name";
    if (quantity != null && unit == null) return "· $quantity $name";
    return "· $name";
  }
}
