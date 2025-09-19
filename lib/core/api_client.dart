import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  String? _token;

  ApiClient({required this.baseUrl});

  void updateToken(String token) => _token = token;

  Map<String, String> _defaultHeaders() {
    final headers = <String, String>{
      'Accept': 'application/json',
    };
    if (_token != null && _token!.isNotEmpty) {
      headers['Authorization'] = 'Bearer $_token';
    }
    return headers;
  }

  Future<http.Response> get(String path) {
    final uri = Uri.parse('$baseUrl$path');
    return http.get(uri, headers: _defaultHeaders());
  }

  Future<http.Response> postForm(String path, Map<String, String> body) {
    final uri = Uri.parse('$baseUrl$path');
    return http.post(uri, headers: _defaultHeaders(), body: body);
  }
}
