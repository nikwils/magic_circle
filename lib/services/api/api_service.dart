import 'dart:async';

import 'package:http/http.dart' as http;

class ApiService {
  static const timeout = 20;
  static const subController = '/api/';

  static const serverDomain = 'eightballapi.com';

  Future<http.Response?> get() async {
    final url = Uri.https(serverDomain, subController);
    final response =
        await http.get(url).timeout(const Duration(seconds: timeout));

    return response;
  }
}
