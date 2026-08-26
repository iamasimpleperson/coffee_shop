class ScheduleModel {
  final int userid;
  final int machineid;
  final int coffeeid;
  final String name;
  final String scheduletime;
  final bool isenable;
  final int id;

  ScheduleModel({
    required this.userid,
    required this.machineid,
    required this.coffeeid,
    required this.name,
    required this.scheduletime,
    required this.isenable,
    required this.id,

  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      userid: int.parse(json['user_id']?.toString() ?? '0'),
      machineid: int.parse(json['machine_id']?.toString() ?? '0'),
      coffeeid: int.parse(json['coffee_id']?.toString() ?? '0'),
      name: json['name'] as String? ?? '',
      scheduletime: json['schedule_time'] as String? ?? '',
      isenable: json['is_enable'] == '1' ? true : false,
      id: int.parse(json['id']?.toString() ?? '0'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userid,
      'machine_id': machineid,
      'coffee_id': coffeeid,
      'name': name,
      'schedule_time': scheduletime,
      'is_enable': isenable ? 1 : 0,
      'id': id,
    };
  }
}
