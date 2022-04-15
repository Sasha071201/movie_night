import 'package:firebase_auth/firebase_auth.dart';
import 'package:movie_night/application/domain/api_client/api_client_exception.dart';

class AuthApiClient {
  final _auth = FirebaseAuth.instance;

  Stream<User?> get userChanges => _auth.userChanges();

  Future<void> signIn({required String email, required String password}) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null && !user.emailVerified) {
        throw FirebaseAuthException(code: 'not-verified');
      }
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      _handleException(e);
    } catch (_) {
      rethrow;
    }
  }

  void _handleException(FirebaseAuthException e) {
    if (e.code.compareTo('user-not-found') == 0) {
      throw ApiClientException('user-not-found');
    } else if (e.code.compareTo('invalid-email') == 0) {
      throw ApiClientException('invalid-email');
    } else if (e.code.compareTo('not-verified') == 0) {
      throw ApiClientException('not-verified');
    } else if (e.code.compareTo('wrong-password') == 0) {
      throw ApiClientException('wrong-password');
    } else if (e.code.compareTo('weak-password') == 0) {
      throw ApiClientException('weak-password');
    } else if (e.code.compareTo('email-already-in-use') == 0) {
      throw ApiClientException('email-already-in-use');
    } else if (e.code.compareTo('too-many-requests') == 0) {
      throw ApiClientException('too-many-requests');
    } else {
      throw ApiClientException('unknown-error');
    }
  }
}
