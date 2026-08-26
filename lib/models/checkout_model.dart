class CheckoutModel {
  final int userid;
  final int firsname;
  final int surname;
  final int postcode;
  final String address;
  final String country;
  final String city;

  CheckoutModel({
    required this.userid,
    required this.firsname,
    required this.surname,
    required this.postcode,
    required this.address,
    required this.country,
    required this.city,
  });

  // Factory constructor to create a UserModel from a JSON map
  factory CheckoutModel.fromJson(Map<String, dynamic> json) {
    return CheckoutModel(
      userid: json['userid'] as int? ?? 0,
      firsname: json['firsname'] as int? ?? 0,
      surname: json['surname'] as int? ?? 0,
      postcode: json['postcode'] as int? ?? 0,
      address: json['address'] as String? ?? 'Unknown',
      country: json['country'] as String? ?? 'Unknown',
      city: json['city'] as String? ?? 'Unknown',
    );
  }

  // Method to convert the UserModel back to a JSON map for POST requests
  Map<String, dynamic> toJson() {
    return {
      'user_id': userid,
      'first_name': firsname,
      'last_name': surname,
      'post_code': postcode,
      'address': address,
      'country': country,
      'city': city,
    };
  }
}
