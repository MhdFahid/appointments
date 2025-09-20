class TreatmentAdd {
  final int id;
  final String name;
  final String male;
  final String female;

  TreatmentAdd({
    required this.id,
    required this.name,
    required this.female,
    required this.male,
  });

  factory TreatmentAdd.fromJson(Map<String, dynamic> json) {
    return TreatmentAdd(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      male: json['male'] ?? "",
      female: json['female'] ?? "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'male': male,
      'female': female,
    };
  }
}

class Treatment {
  final int id;
  final List<dynamic>
      branches; // Replace dynamic with Branch model if you have one
  final String name;
  final String duration;
  final String price;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Treatment({
    required this.id,
    required this.branches,
    required this.name,
    required this.duration,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Treatment.fromJson(Map<String, dynamic> json) {
    return Treatment(
      id: json['id'],
      branches: json['branches'] ?? [],
      name: json['name'],
      duration: json['duration'],
      price: json['price'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'branches': branches,
      'name': name,
      'duration': duration,
      'price': price,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
