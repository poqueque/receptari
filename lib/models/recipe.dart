class Recipe {
  final int id;
  final String title;
  final String imageUrl;
  final String category;
  final int minutes;
  final int servings;

  Recipe({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.category,
    required this.minutes,
    required this.servings,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
    id: json["id"],
    title: json["title"],
    imageUrl: json["imageUrl"],
    category: json["category"],
    minutes: json["minutes"],
    servings: json["servings"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "imageUrl": imageUrl,
    "category": category,
    "minutes": minutes,
    "servings": servings,
  };

  @override
  bool operator ==(Object other) => other is Recipe && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
