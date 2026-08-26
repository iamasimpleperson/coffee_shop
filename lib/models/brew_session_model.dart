class BrewSessionModel {
  final int userid;
  final int coffeeid;
  final int machineid;
  final int size;
  final String streng;
  final bool status;
  final int id;
  final DateTime startat;
  final DateTime completedat;

  BrewSessionModel({
    required this.userid,
    required this.coffeeid,
    required this.machineid,
    required this.size,
    required this.streng,
    required this.status,
    required this.id,
    required this.startat,
    required this.completedat,
  });

  // Factory constructor to create a UserModel from a JSON map
  factory BrewSessionModel.fromJson(Map<String, dynamic> json) {
    return BrewSessionModel(
      id: json['id'] as int? ?? 0,
      userid: json['userid'] as int? ?? 0,
      coffeeid: json['coffeeid'] as int? ?? 0,
      machineid: json['machineid'] as int? ?? 0,
      size: json['size'] as int? ?? 0,
      streng: json['streng'] as String? ?? 'Unknown',
      status: json['status'] as bool? ?? true,
      startat: json['startat'] as DateTime? ?? DateTime.now(),
      completedat: json['completedat'] as DateTime? ?? DateTime.now(),
    );
  }

  // Method to convert the UserModel back to a JSON map for POST requests
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userid,
      'coffee_id': coffeeid,
      'machine_id': machineid,
      'size': size,
      'streng': streng,
      'status': status,
      'start_at': startat,
      'completed_at': completedat,
    };
  }
}
