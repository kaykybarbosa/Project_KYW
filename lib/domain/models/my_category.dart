class MyCategory {
  const MyCategory({
    required this.id,
    required this.name,
    required this.isCheck,
  });

  final String id;
  final String name;
  final bool isCheck;

  MyCategory copyWith({
    String? id,
    String? name,
    bool? isCheck,
  }) {
    return MyCategory(
      id: id ?? this.id,
      name: name ?? this.name,
      isCheck: isCheck ?? this.isCheck,
    );
  }
}
