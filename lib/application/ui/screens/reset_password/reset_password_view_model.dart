import 'package:flutter/material.dart';

import '../../../../generated/l10n.dart';
import '../../../domain/api_client/api_client_exception.dart';
import '../../../repository/auth_repository.dart';
import '../../widgets/dialog_widget.dart';


class ResetPasswordViewModel extends ChangeNotifier {

  final _authRepository = AuthRepository();

  final _emailTextController = TextEditingController();
  TextEditingController get emailTextController => _emailTextController;
  
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  bool _isAuthProgress = false;
  bool get canStartAuth => !_isAuthProgress;
  bool get isAuthProgress => _isAuthProgress;

  final BuildContext context;

  ResetPasswordViewModel(this.context);

  Future<String> _resetPassword(String email) async {
    try {
      await _authRepository.resetPassword(email: email);
    } on ApiClientException catch (e) {
      return e.asString(context);
    } catch (_) {
      return S.of(context).unknown_error_write_to_support;
    }
    return '';
  }

  Future<void> reset(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final email = _emailTextController.text.trim();
   
    if (email.isEmpty) {
      _updateState(
        context: context,
        errorMessage: S.of(context).fill_in_the_mail,
        isAuthProgress: false,
      );
      return;
    }
   
    _updateState(
      context: context,
      errorMessage: '',
      isAuthProgress: true,
    );

    final errorMessage = await _resetPassword(email);
    _updateState(
      context: context,
      errorMessage: errorMessage,
      isAuthProgress: false,
    );
    if (_errorMessage.isEmpty) {
      _emailTextController.clear();
      DialogWidget.showSnackBar(
        context: context,
        duration: const Duration(seconds: 3),
        text: S.of(context).request_has_been_sent,
      );
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
    _emailTextController.dispose();
    super.dispose();
  }
} 
