import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vsga_app/db/akun_helper.dart';
import 'package:vsga_app/models/akun.dart';

class AuthVModels extends ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  Akun? _currentUser;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  Akun? get currentUser => _currentUser;

  Future<Akun?> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final result = await AkunHelper().loginAkun(username, password);

      if (result != null) {
        _currentUser = result;
        await _saveSession(result);
      } else {
        _currentUser = null;
        _errorMessage = 'Username atau password salah';
      }
    } catch (e) {
      _errorMessage = 'Terjadi kesalahan: $e';
      _currentUser = null;
    }

    _isLoading = false;
    notifyListeners();
    return _currentUser;
  }

  Future<void> _saveSession(Akun akun) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', akun.username!);
    await prefs.setInt('id', akun.id!);
    await prefs.setBool('is_logged_in', true); 
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    _currentUser = null;
    notifyListeners();
  }

  Future<bool> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;

    if (isLoggedIn) {
      final username = prefs.getString('username');
      final id = prefs.getInt('id');

      if (username != null && id != null) {
        _currentUser = Akun(id: id, username: username, password: '');
        return true;
      }
    }

    return false;
  }
}
