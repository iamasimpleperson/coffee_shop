class CoffeeModel {
  final String id;
  final String name;
  final String image;

  CoffeeModel({
    required this.id,
    required this.name,
    required this.image,
  });

  CoffeeModel copyWith({
    String? id,
    String? name,
    String? image,
  }) {
    return CoffeeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
    );
  }

  factory CoffeeModel.fromJson(Map<String, dynamic> json) {
    return CoffeeModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? 'Unknown Coffee',
      image: json['image'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }
}
