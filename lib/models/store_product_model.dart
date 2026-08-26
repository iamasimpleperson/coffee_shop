class StoreProductModel {
  final int categoryid;
  final String name;
  final String image;
  final String description;
  final String id;
  final double price;
  final List<String> sizes;

  StoreProductModel({
    required this.categoryid,
    required this.name,
    required this.image,
    required this.description,
    required this.id,
    this.price = 9.0, // Default price since API doesn't provide it
    this.sizes = const ['250g', '500g', '1kg'], // Default sizes
  });

  factory StoreProductModel.fromJson(Map<String, dynamic> json) {
    return StoreProductModel(
      categoryid: int.tryParse(json['category_id']?.toString() ?? '0') ?? 0,
      name: json['name'] as String? ?? 'Unknown Coffee',
      image: json['image'] as String? ?? '',
      description: json['description'] as String? ?? 'No description',
      id: json['id']?.toString() ?? '',
      price: double.tryParse(json['price']?.toString() ?? '9.0') ?? 9.0,
      sizes: json['sizes'] != null ? List<String>.from(json['sizes']) : ['250g', '500g', '1kg'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'category_id': categoryid,
      'name': name,
      'image': image,
      'description': description,
      'id': id,
      'price': price,
      'sizes': sizes,
    };
  }
}
