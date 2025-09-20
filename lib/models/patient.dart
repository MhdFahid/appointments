class PatientRecord {
  final int id;
  final List<PatientDetails> patientDetailsSet;
  final Branch? branch;
  final String user;
  final String payment;
  final String name;
  final String phone;
  final String address;
  final double? price;
  final double totalAmount;
  final double discountAmount;
  final double advanceAmount;
  final double balanceAmount;
  final String? dateNdTime;
  final bool isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  PatientRecord({
    required this.id,
    required this.patientDetailsSet,
    this.branch,
    required this.user,
    required this.payment,
    required this.name,
    required this.phone,
    required this.address,
    this.price,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    this.dateNdTime,
    required this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory PatientRecord.fromJson(Map<String, dynamic> json) {
    return PatientRecord(
      id: json['id'] ?? 0,
      patientDetailsSet: (json['patientdetails_set'] as List<dynamic>?)
              ?.map((e) => PatientDetails.fromJson(e))
              .toList() ??
          [],
      branch: json['branch'] != null ? Branch.fromJson(json['branch']) : null,
      user: json['user'] ?? '',
      payment: json['payment'] ?? '',
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
      discountAmount: (json['discount_amount'] as num?)?.toDouble() ?? 0,
      advanceAmount: (json['advance_amount'] as num?)?.toDouble() ?? 0,
      balanceAmount: (json['balance_amount'] as num?)?.toDouble() ?? 0,
      dateNdTime: json['date_nd_time'],
      isActive: json['is_active'] ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientdetails_set': patientDetailsSet.map((e) => e.toJson()).toList(),
      'branch': branch?.toJson(),
      'user': user,
      'payment': payment,
      'name': name,
      'phone': phone,
      'address': address,
      'price': price,
      'total_amount': totalAmount,
      'discount_amount': discountAmount,
      'advance_amount': advanceAmount,
      'balance_amount': balanceAmount,
      'date_nd_time': dateNdTime,
      'is_active': isActive,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

class PatientDetails {
  final int id;
  final int male;
  final int? female;
  final int patient;
  final int treatment;
  final String treatmentName;

  PatientDetails({
    required this.id,
    required this.male,
    this.female,
    required this.patient,
    required this.treatment,
    required this.treatmentName,
  });

  factory PatientDetails.fromJson(Map<String, dynamic> json) {
    return PatientDetails(
      id: json['id'] ?? 0,
      male: int.tryParse(json['male'].toString()) ?? 0,
      female: json['female'] != null && json['female'] != ''
          ? int.tryParse(json['female'].toString())
          : null,
      patient: json['patient'] ?? 0,
      treatment: json['treatment'] ?? 0,
      treatmentName: json['treatment_name'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'male': male,
      'female': female,
      'patient': patient,
      'treatment': treatment,
      'treatment_name': treatmentName,
    };
  }
}

class Branch {
  final int id;
  final String name;
  final int patientsCount;
  final String location;
  final String phone;
  final String mail;
  final String address;
  final String? gst;
  final bool isActive;

  Branch({
    required this.id,
    required this.name,
    required this.patientsCount,
    required this.location,
    required this.phone,
    required this.mail,
    required this.address,
    this.gst,
    required this.isActive,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      patientsCount: json['patients_count'] ?? 0,
      location: json['location'] ?? '',
      phone: json['phone'] ?? '',
      mail: json['mail'] ?? '',
      address: json['address'] ?? '',
      gst: json['gst'],
      isActive: json['is_active'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'patients_count': patientsCount,
      'location': location,
      'phone': phone,
      'mail': mail,
      'address': address,
      'gst': gst,
      'is_active': isActive,
    };
  }
}
