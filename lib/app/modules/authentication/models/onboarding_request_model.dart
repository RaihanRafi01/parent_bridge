class ChildModel {
  final String name;
  final String dateOfBirth;

  ChildModel({required this.name, required this.dateOfBirth});

  Map<String, dynamic> toJson() {
    return {'name': name, 'date_of_birth': dateOfBirth};
  }
}

class OnboardingRequestModel {
  final String name;
  final String phone;
  final String state;
  final List<ChildModel> children;
  final bool courtMandated;
  final String role;
  final String mode;
  final String? partnerCode;

  OnboardingRequestModel({
    required this.name,
    required this.phone,
    required this.state,
    required this.children,
    required this.courtMandated,
    required this.role,
    required this.mode,
    this.partnerCode,
  });

  Map<String, dynamic> toJson() {
    final json = {
      'name': name,
      'phone': phone,
      'state': state,
      'children': children.map((child) => child.toJson()).toList(),
      'court_mandated': courtMandated,
      'role': role,
      'mode': mode,
    };

    // Only add partner_code if it's not null and not empty
    if (partnerCode != null && partnerCode!.isNotEmpty) {
      json['partner_code'] = partnerCode!;
    }

    return json;
  }
}
