class CategoryModel {
  final String id;
  final String name;

  CategoryModel({required this.id, required this.name});

  // Convert to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
  };

  // Convert from JSON
  static CategoryModel fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'],
    name: json['name'],
  );
}
