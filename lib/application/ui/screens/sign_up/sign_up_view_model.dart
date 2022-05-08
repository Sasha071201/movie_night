import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/repository/account_repository.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/api_client/api_client_exception.dart';
import '../../../repository/auth_repository.dart';
import '../../navigation/app_navigation.dart';
import '../../widgets/dialog_widget.dart';

class SignUpViewModel extends ChangeNotifier {
  final _authRepository = AuthRepository();
  final _accountRepository = AccountRepository();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  TextEditingController get emailTextController => _emailTextController;
  TextEditingController get passwordTextController => _passwordTextController;
  TextEditingController get confirmPasswordTextController =>
      _confirmPasswordTextController;
  final _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  BuildContext context;

  SignUpViewModel(this.context);

  Future<String> _signUp(String email, String password) async {
    try {
      await _authRepository.signUp(email: email, password: password);
    } on ApiClientException catch (e) {
      return e.asString(context);
    } catch (_) {
      return S.of(context).unknown_error_write_to_support;
    }
    return '';
  }

  Future<void> auth(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final name = _nameController.text.trim();
    final email = _emailTextController.text.trim();
    final password = _passwordTextController.text.trim();
    final confirmPassword = _confirmPasswordTextController.text.trim();

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
    if (password.compareTo(confirmPassword) != 0) {
      _updateState(
        context: context,
        errorMessage: S.of(context).passwords_do_not_match,
        isAuthProgress: false,
      );
      return;
    }

    _updateState(
      context: context,
      errorMessage: '',
      isAuthProgress: true,
    );

    final errorMessage = await _signUp(email, password);
    _updateState(
      context: context,
      errorMessage: errorMessage,
      isAuthProgress: false,
    );
    if (_errorMessage.isEmpty) {
      if (name.isNotEmpty) {
        await _accountRepository.setUserName(name);
      }
      _emailTextController.clear();
      _passwordTextController.clear();
      _confirmPasswordTextController.clear();
      AppNavigation.resetNavigation(context);
    }
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
    _nameController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
    super.dispose();
  }
}
