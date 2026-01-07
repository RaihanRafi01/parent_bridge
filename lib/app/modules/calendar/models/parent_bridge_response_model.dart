class ParentBridgeResponseModel {
  final ParentBridgeData data;
  final String message;

  ParentBridgeResponseModel({required this.data, required this.message});

  factory ParentBridgeResponseModel.fromJson(Map<String, dynamic> json) {
    return ParentBridgeResponseModel(
      data: ParentBridgeData.fromJson(json['data']),
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data.toJson(), 'message': message};
  }
}

class ParentBridgeData {
  final int id;
  final String father;
  final String mother;
  final String mode;
  final List<Child> children;
  final String createdAt;

  ParentBridgeData({
    required this.id,
    required this.father,
    required this.mother,
    required this.mode,
    required this.children,
    required this.createdAt,
  });

  factory ParentBridgeData.fromJson(Map<String, dynamic> json) {
    return ParentBridgeData(
      id: json['id'] ?? 0,
      father: json['father'] ?? '',
      mother: json['mother'] ?? '',
      mode: json['mode'] ?? '',
      children:
          (json['children'] as List<dynamic>?)
              ?.map((childJson) => Child.fromJson(childJson))
              .toList() ??
          [],
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'father': father,
      'mother': mother,
      'mode': mode,
      'children': children.map((child) => child.toJson()).toList(),
      'created_at': createdAt,
    };
  }
}

class Child {
  final int id;
  final String name;

  Child({required this.id, required this.name});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(id: json['id'] ?? 0, name: json['name'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
