class DeleteHolidayRequest {
  final String holidayId;

  DeleteHolidayRequest({
    required this.holidayId,
  });

  // Convert EventRequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'holiday_id': holidayId,
    };
  }

  // Create an EventRequestModel from JSON
  factory DeleteHolidayRequest.fromJson(Map<String, dynamic> json) {
    return DeleteHolidayRequest(
      holidayId: json['holiday_id'] ?? '',
    );
  }
}
