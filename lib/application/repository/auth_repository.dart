import 'package:firebase_auth/firebase_auth.dart';

import '../domain/api_client/auth_api_client.dart';

class AuthRepository {
  final _apiClient = AuthApiClient();

  Stream<User?> get userChanges => _apiClient.userChanges;

  Future<void> signIn({required String email, required String password}) async {
    await _apiClient.signIn(email: email, password: password);
  }

  Future<void> signUp({required String email, required String password}) async {
    await _apiClient.signUp(email: email, password: password);
  }

  Future<void> resetPassword({required String email}) async {
    await _apiClient.resetPassword(email: email);
  }

  Future<void> signOut() async {
    await _apiClient.signOut();
  }
}
