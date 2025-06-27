import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _message;
  String? get message => _message;

  bool get isAuthenticated => _auth.currentUser != null;

  Future<bool> signUpUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _message = null;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _message = e.message;
      notifyListeners();
      return false;
    } catch (e) {
      _message = 'Erro inesperado.';
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _message = null;
      notifyListeners();
      return true;
    } on FirebaseAuthException catch (e) {
      _message = e.message;
      notifyListeners();
      return false;
    } catch (e) {
      _message = 'Erro inesperado.';
      notifyListeners();
      return false;
    }
  }

  void logout() async {
    await _auth.signOut();
    notifyListeners();
  }

  String? get token => _auth.currentUser?.uid; // ou use getIdToken() se quiser um JWT
}
