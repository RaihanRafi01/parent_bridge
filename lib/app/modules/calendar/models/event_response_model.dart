class EventResponseModel {
  final int id;
  final String child;
  final int childId;
  final String title;
  final String postBy;
  final String type;
  final String date;
  final String startTime;
  final String endTime;
  final String location;
  final String repeat;
  final String customStartDate;
  final String customEndDate;
  final int reminderMinutes;
  final String description;
  final String createdAt;
  final String updatedAt;

  EventResponseModel({
    required this.id,
    required this.child,
    required this.childId,
    required this.title,
    required this.postBy,
    required this.type,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.repeat,
    required this.customStartDate,
    required this.customEndDate,
    required this.reminderMinutes,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert EventResponseModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'child': child, // child should now be an int, representing the child ID
      'title': title,
      'post_by': postBy,
      'type': type,
      'date': date,
      'start_time': startTime,
      'end_time': endTime,
      'location': location,
      'repeat': repeat,
      'custom_start_date': customStartDate,
      'custom_end_date': customEndDate,
      'reminder_minutes': reminderMinutes,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Create EventResponseModel from JSON
  factory EventResponseModel.fromJson(Map<String, dynamic> json) {
    // Extract child id, assuming the child is an object and we need to get the 'id' field
    final childName = json['child'] != null ? json['child']['name'] ?? '' : '';
    final childId = json['child'] != null ? json['child']['id'] ?? 0 : 0;

    return EventResponseModel(
      id: json['id'] ?? 0,
      child: childName,
      childId: childId, // Set child as the ID of the child
      title: json['title'] ?? '',
      type: json['type'] ?? '',
      postBy: json['post_by'] ?? '',
      date: json['date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      location: json['location'] ?? '',
      repeat: json['repeat'] ?? '',
      customStartDate: json['custom_start_date'] ?? '',
      customEndDate: json['custom_end_date'] ?? '',
      reminderMinutes: json['reminder_minutes'] ?? 0,
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
