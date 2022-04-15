import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/repository/auth_repository.dart';

class InitialViewModel extends ChangeNotifier {
  final _authRepository = AuthRepository();
  Stream<User?> get userChanges => _authRepository.userChanges;
}
