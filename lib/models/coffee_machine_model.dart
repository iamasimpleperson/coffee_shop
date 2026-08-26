class CoffeeMachineModel {
  final String name;
  final String status;
  final String connectionstatus;
  final int waterlevel;
  final int beanlevel;
  final int coffeecount;
  final int usageday;
  final int creancount;
  final int id;

  CoffeeMachineModel({
    required this.name,
    required this.status,
    required this.connectionstatus,
    required this.waterlevel,
    required this.beanlevel,
    required this.coffeecount,
    required this.usageday,
    required this.creancount,
    required this.id,
  });

  // Factory constructor to create a UserModel from a JSON map
  factory CoffeeMachineModel.fromJson(Map<String, dynamic> json) {
    return CoffeeMachineModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? 'Unknown',
      status: json['status'] as String? ?? 'Unknown',
      connectionstatus: json['connectionstatus'] as String? ?? 'Unknown',
      waterlevel: json['waterlevel'] as int? ?? 0,
      beanlevel: json['beanlevel'] as int? ?? 0,
      coffeecount: json['coffeecount'] as int? ?? 0,
      usageday: json['usageday'] as int? ?? 0,
      creancount: json['creancount'] as int? ?? 0,
    );
  }

  // Method to convert the UserModel back to a JSON map for POST requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'connection_status': connectionstatus,
      'water_level': waterlevel,
      'bean_level': beanlevel,
      'coffee_count': coffeecount,
      'usage_day': usageday,
      'clean_count': creancount,
    };
  }
}
