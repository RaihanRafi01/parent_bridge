class HolidayViewResponseModel {
  final int id;
  final String child;
  final String name;
  final String postBy;
  final String startDate;
  final String endDate;
  final String assignedTo;
  final String location;
  final String description;
  final String createdAt;
  final String updatedAt;
  final String message;

  HolidayViewResponseModel({
    required this.id,
    required this.child,
    required this.name,
    required this.postBy,
    required this.startDate,
    required this.endDate,
    required this.assignedTo,
    required this.location,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.message,
  });

  factory HolidayViewResponseModel.fromJson(Map<String, dynamic> json) {
    return HolidayViewResponseModel(
      id: json['id'] ?? 0,
      child: json['child_name'] ?? '',
      name: json['name'] ?? '',
      postBy: json['post_by'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      assignedTo: json['assigned_to'] ?? '',
      location: json['location'] ?? '',
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
      'name': name,
      'post_by': postBy,
      'start_date': startDate,
      'end_date': endDate,
      'assigned_to': assignedTo,
      'location': location,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'message': message,
    };
  }
}
