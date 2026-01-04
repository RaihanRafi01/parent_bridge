class HolidayRequestModel {
  final int child;
  final String name;
  final String startDate;
  final String endDate;
  final String assignedTo;
  final String location;
  final String description;

  HolidayRequestModel({
    required this.child,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.assignedTo,
    required this.location,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'child': child,
      'name': name,
      'start_date': startDate,
      'end_date': endDate,
      'assigned_to': assignedTo,
      'location': location,
      'description': description,
    };
  }

  factory HolidayRequestModel.fromJson(Map<String, dynamic> json) {
    return HolidayRequestModel(
      child: json['child'],
      name: json['name'],
      startDate: json['start_date'],
      endDate: json['end_date'],
      assignedTo: json['assigned_to'],
      location: json['location'],
      description: json['description'],
    );
  }
}
