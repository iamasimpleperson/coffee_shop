class FavouriteModel {
  final String userid;
  final String coffeeid;
  final String name;
  final String size;
  final String strength;
  final String hightlights;
  final String id;

  FavouriteModel({
    required this.userid,
    required this.coffeeid,
    required this.name,
    required this.size,
    required this.strength,
    required this.hightlights,
    required this.id,
  });

  factory FavouriteModel.fromJson(Map<String, dynamic> json) {
    return FavouriteModel(
      userid: json['userid']?.toString() ?? '',
      coffeeid: json['coffeeid']?.toString() ?? '',
      name: json['name'] as String? ?? 'Unknown Coffee',
      size: json['size'] as String? ?? '',
      strength: json['strength'] as String? ?? '',
      hightlights: json['hightlights'] as String? ?? '',
      id: json['id']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userid,
      'coffee_id': coffeeid,
      'name': name,
      'size': size,
      'strength': strength,
      'hightlights': hightlights,
      'id': id,
    };
  }
}
