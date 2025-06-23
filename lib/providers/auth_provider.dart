import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AuthProvider with ChangeNotifier {
  String? _message;
  String? _token;

  final String _url = "https://identitytoolkit.googleapis.com";
  final String _resource = "/v1/accounts";
  final String _apiKey = dotenv.env['API_KEY'] ?? '';


  String? get token => _token;
  String? get message => _message;
  bool get isAuthenticated => _token != null;

  Future<bool> signUpUser(String email, String password) async {
    final uri = Uri.parse('$_url$_resource:signUp?key=$_apiKey');

    try {
      final response = await http.post(uri, body: {
        'email': email,
        'password': password,
        'returnSecureToken': 'true'
      });
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _token = data['idToken'];
        _message = null;
        notifyListeners();
        return true;
      } else {
        _message = data['error']?['message'] ?? 'Erro desconhecido';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _message = 'Erro ao conectar com o servidor.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInUser(String email, String password) async {
    final uri = Uri.parse('$_url$_resource:signInWithPassword?key=$_apiKey');

    try {
      final response = await http.post(uri, body: {
        'email': email,
        'password': password,
        'returnSecureToken': 'true'
      });

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        _token = data['idToken'];
        _message = null;
        notifyListeners();
        return true;
      } else {
        _message = data['error']?['message'] ?? 'Erro desconhecido';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _message = 'Erro ao conectar com o servidor.';
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _token = null;
    _message = null;
    notifyListeners();
  }
}
