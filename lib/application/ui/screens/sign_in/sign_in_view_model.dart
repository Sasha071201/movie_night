import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/repository/auth_repository.dart';
import 'package:movie_night/application/ui/widgets/dialog_widget.dart';
import 'package:movie_night/generated/l10n.dart';

import '../../../domain/api_client/api_client_exception.dart';

class SignInViewModel extends ChangeNotifier {
  final _authRepository = AuthRepository();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  TextEditingController get emailTextController => _emailTextController;
  TextEditingController get passwordTextController => _passwordTextController;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  late BuildContext _context;

  SignInViewModel(BuildContext context) {
    _context = context;
    asyncInit();
  }

  Future<void> asyncInit() async {
    final user = await _authRepository.userChanges.first;
    if (user != null && !user.emailVerified) {
      DialogWidget.showSnackBar(
        context: _context,
        text: S.of(_context).confirm_mail,
      );
    }
  }

  Future<String> _signIn(String email, String password) async {
    try {
      await _authRepository.signIn(email: email, password: password);
    } on ApiClientException catch (e) {
      return e.asString(_context);
    } catch (_) {
      return S.of(_context).unknown_error_write_to_support;
    }
    return '';
  }

  Future<void> auth(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final email = _emailTextController.text.trim();
    final password = _passwordTextController.text.trim();

    if (email.isEmpty) {
      _updateState(
        context: context,
        errorMessage: S.of(context).fill_in_the_mail,
        isAuthProgress: false,
      );
      return;
    }

    if (password.isEmpty) {
      _updateState(
        context: context,
        errorMessage: S.of(context).fill_in_the_password,
        isAuthProgress: false,
      );
      return;
    }

    _updateState(
      context: context,
      errorMessage: '',
      isAuthProgress: true,
    );

    final errorMessage = await _signIn(email, password);
    if (errorMessage.isEmpty) {
      _emailTextController.clear();
      _passwordTextController.clear();
    }
    _updateState(
      context: context,
      errorMessage: errorMessage,
      isAuthProgress: false,
    );
  }

  void _updateState({
    required BuildContext context,
    required String errorMessage,
    required bool isAuthProgress,
  }) {
    _errorMessage = errorMessage;
    _isAuthProgress = isAuthProgress;
    if (_errorMessage.isNotEmpty) {
      _showDialog(context);
    }
    notifyListeners();
  }

  void _showDialog(BuildContext context) {
    if (_errorMessage.isNotEmpty) {
      DialogWidget.showSnackBar(
        context: context,
        duration: const Duration(seconds: 3),
        text: _errorMessage,
      );
    }
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }
}
