class HolidayViewResponseModel {
  final int id;
  final int? child; // Child can be null
  final String name;
  final String startDate;
  final String endDate;
  final String assignedTo;
  final String location;
  final String description;
  final String createdAt;
  final String updatedAt;

  HolidayViewResponseModel({
    required this.id,
    this.child,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.assignedTo,
    required this.location,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert HolidayResponseModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'child': child,
      'name': name,
      'start_date': startDate,
      'end_date': endDate,
      'assigned_to': assignedTo,
      'location': location,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // Create HolidayResponseModel from JSON
  factory HolidayViewResponseModel.fromJson(Map<String, dynamic> json) {
    return HolidayViewResponseModel(
      id: json['id'] ?? 0,
      child: json['child'] ?? null, // child can be null
      name: json['name'] ?? '',
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
      assignedTo: json['assigned_to'] ?? '',
      location: json['location'] ?? '',
      description: json['description'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
    );
  }
}
