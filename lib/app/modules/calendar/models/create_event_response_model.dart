class CreateEventResponseModel {
  final int id;
  final int child;
  final String title;
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
  final String message;

  CreateEventResponseModel({
    required this.id,
    required this.child,
    required this.title,
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
    required this.message,
  });

  factory CreateEventResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateEventResponseModel(
      id: json['id'] ?? 0,
      child: json['child'] ?? 0,
      title: json['title'] ?? '',
      type: json['type'] ?? '',
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
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'child': child,
      'title': title,
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
      'message': message,
    };
  }
}
