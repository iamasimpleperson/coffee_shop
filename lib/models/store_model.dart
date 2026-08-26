class StoreModel {
  final int id;
  final String name;

  StoreModel({required this.id, required this.name});

  factory StoreModel.fromJson(Map<String, dynamic> json) {
    return StoreModel(
      id: int.parse(json['id']?.toString() ?? '0'),
      name: json['name'] as String? ?? 'Unknown Coffee',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
