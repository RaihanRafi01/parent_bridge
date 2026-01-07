class DeleteEventRequest {
  final String eventId;

  DeleteEventRequest({
    required this.eventId,
  });

  // Convert EventRequestModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'event_id': eventId,
    };
  }

  // Create an EventRequestModel from JSON
  factory DeleteEventRequest.fromJson(Map<String, dynamic> json) {
    return DeleteEventRequest(
      eventId: json['event_id'] ?? '',
    );
  }
}
