
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../repository/auth_repository.dart';

final authProvider = Provider((ref) => AuthRepository());

final authController =
StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier(ref.read(authProvider));
});

class AuthNotifier extends StateNotifier<bool> {
  final AuthRepository repo;

  AuthNotifier(this.repo) : super(false);

  /// 🔥 LOGIN
  Future<Map<String, dynamic>> login(
      String phone,
      String password,
      ) async {
    state = true;

    try {
      final result = await repo.login(phone, password);

      if (result["status"] != true) {
        throw Exception(result["message"] ?? "Login failed");
      }

      /// ⚠️ return full response (safe approach)
      return result;

    } finally {
      state = false;
    }
  }

  /// 🔥 SIGNUP
  Future<void> signup(Map<String, dynamic> data) async {
    state = true;

    try {
      final result = await repo.signup(data);

      if (result["status"] != true) {
        throw Exception(result["message"] ?? "Signup failed");
      }

    } finally {
      state = false;
    }
  }
}