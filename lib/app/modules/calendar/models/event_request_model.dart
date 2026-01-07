class EventRequestModel {
  final String type;
  final String startDate;
  final String endDate;

  EventRequestModel({
    required this.type,
    required this.startDate,
    required this.endDate,
  });

  // Convert EventRequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'start_date': startDate,
      'end_date': endDate,
    };
  }

  // Create an EventRequestModel from JSON
  factory EventRequestModel.fromJson(Map<String, dynamic> json) {
    return EventRequestModel(
      type: json['type'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
    );
  }
}
