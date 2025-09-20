import 'package:appointments/models/branch.dart';
import 'package:appointments/models/treatment.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import '../core/api_client.dart';
import '../models/patient.dart';

class AuthProvider with ChangeNotifier {
  final ApiClient api =
      ApiClient(baseUrl: 'https://flutter-amr.noviindus.in/api/');
  String? _token;
  bool authIsLoading = false;

  String? get token => _token;

  Future<bool> login(String username, String password) async {
    authIsLoading = true;
    notifyListeners();
    final response = await api.postForm('Login', {
      'username': username,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _token = data['token'];
      if (_token != null) {
        api.updateToken(_token!);
        fetchTreatments();
        fetchBranches();
        authIsLoading = false;
        notifyListeners();
        return true;
      }
      authIsLoading = false;
    }
    authIsLoading = false;
    notifyListeners();
    return false;
  }

  List<Treatment> _treatments = [];
  List<Treatment> get treatments => _treatments;
  bool isFetchingTreatments = false;

  List<Branch> _branches = [];
  List<Branch> get branches => _branches;
  bool isFetchingBranches = false;

  Future<void> fetchTreatments() async {
    isFetchingTreatments = true;
    notifyListeners();

    try {
      final response = await api.get('TreatmentList');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _treatments = (data['treatments'] as List)
            .map<Treatment>((json) => Treatment.fromJson(json))
            .toList();
      } else {
        // TODO: Handle error
      }
    } catch (e) {
      // TODO: Handle error
    }
    isFetchingTreatments = false;
    notifyListeners();
  }

  Future<void> fetchBranches() async {
    isFetchingBranches = true;
    notifyListeners();

    try {
      final response = await api.get('BranchList');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _branches = (data['branches'] as List)
            .map<Branch>((json) => Branch.fromJson(json))
            .toList();
      } else {
        // TODO: Handle error
      }
    } catch (e) {
      // TODO: Handle error
    }

    isFetchingBranches = false;
    notifyListeners();
  }

  Future<void> fetchPatients() async {
    if (_token == null) {
      _error = "Not authenticated";
      notifyListeners();
      return;
    }
    patientIsLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await api.get('PatientList');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _patients = data['patient']
            .map<PatientRecord>((json) => PatientRecord.fromJson(json))
            .toList();
      } else {
        _error = 'Failed to load patients';
      }
    } catch (e) {
      _error = e.toString();
    }

    patientIsLoading = false;
    notifyListeners();
  }

  int _maleCount = 0;
  int _femaleCount = 0;
  int get maleCount => _maleCount;
  int get femaleCount => _femaleCount;

  void incrementMale() {
    _maleCount++;
    notifyListeners();
  }

  void decrementMale() {
    if (_maleCount > 0) {
      _maleCount--;
      notifyListeners();
    }
  }

  void incrementFemale() {
    _femaleCount++;
    notifyListeners();
  }

  void decrementFemale() {
    if (_femaleCount > 0) {
      _femaleCount--;
      notifyListeners();
    }
  }

  final List<Treatment> _selectedTreatments = [];

  List<Treatment> get selectedTreatments => _selectedTreatments;

  void addTreatment(Treatment treatment) {
    _selectedTreatments.add(treatment);
    notifyListeners();
  }

  void removeTreatment(Treatment treatment) {
    _selectedTreatments.remove(treatment);
    notifyListeners();
  }

  Branch branchSelect = Branch(
    id: 0,
    name: "name",
    patientsCount: 22,
    location: "location",
    phone: "phone",
    mail: "mail",
    address: "address",
    isActive: false,
  );
  Branch get selectedBranch => branchSelect;
  List<PatientRecord> _patients = [];
  bool patientIsLoading = false;
  String? _error;

  List<PatientRecord> get patients => _patients;
  bool get isFetchingPatients => patientIsLoading;
  String? get error => _error;

  bool isRegisteringPatient = false;

  Future<bool> registerPatient({
    required String name,
    required String executive,
    required String phone,
    required String address,
    required double payment,
    required double totalAmount,
    required double discountAmount,
    required double advanceAmount,
    required Branch branch,
    required String balanceAmount,
    required String dateAndTime,
  }) async {
    isRegisteringPatient = true;
    notifyListeners();

    try {
      final response = await api.postForm('PatientRegister', {
        'name': name,
        'executive': executive,
        'payment': payment.toString(),
        'phone': phone,
        'address': address,
        'total_amount': totalAmount.toString(),
        'discount_amount': discountAmount.toString(),
        'advance_amount': advanceAmount.toString(),
        'balance_amount': balanceAmount,
        'date_nd_time': DateTime.now().toString(),
        "id": "",
        'treatment':
            jsonEncode(_selectedTreatments.map((t) => t.toJson()).toList()),
        'branch': jsonEncode(branch.toJson()),
      });

      if (response.statusCode == 200) {
        await fetchPatients();
        isRegisteringPatient = false;
        notifyListeners();
        return true;
      } else {}
    } catch (e) {}

    isRegisteringPatient = false;
    notifyListeners();
    return false;
  }
}
