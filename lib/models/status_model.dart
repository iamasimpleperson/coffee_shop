class StatusModel {
  final String message;
  // Add other fields here if your API returns more data!

  StatusModel({
    required this.message,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      // We use a fallback string just in case the key doesn't exist
      message: json['message'] ?? 'No message provided by API', 
    );
  }
}
