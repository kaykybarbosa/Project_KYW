class CategoryModel {
  const CategoryModel({
    required this.id,
    required this.name,
    required this.isCheck,
  });

  final String id;
  final String name;
  final bool isCheck;

  CategoryModel copyWith({
    String? id,
    String? name,
    bool? isCheck,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isCheck: isCheck ?? this.isCheck,
    );
  }
}
