import 'package:flutter/cupertino.dart';

import '../../../generated/l10n.dart';

enum ExceptionSolution { none, update, showMessage }

class ApiClientException implements Exception {
  String code;
  ExceptionSolution solution;

  ApiClientException(
    this.code, [
    this.solution = ExceptionSolution.none,
  ]);

  String asString(BuildContext context) {
    if (code.compareTo('user-not-found') == 0) {
      return S.of(context).no_such_user;
    } else if (code.compareTo('network-error') == 0) {
      return S.of(context).network_error_check_your_internet_connection;
    } 
    else if (code.compareTo('movie-details-not-saved') == 0) {
      return S.of(context).movie_details_not_saved;
    } 
    else if (code.compareTo('serial-details-not-saved') == 0) {
      return S.of(context).serial_details_not_saved;
    } 
    else if (code.compareTo('actor-details-not-saved') == 0) {
      return S.of(context).actor_details_not_saved;
    } 
    else if (code.compareTo('invalid-email') == 0) {
      return S.of(context).email_entered_incorrectly;
    } else if (code.compareTo('not-verified') == 0) {
      return S.of(context).confirm_mail;
    } else if (code.compareTo('wrong-password') == 0) {
      return S.of(context).incorrect_password;
    } else if (code.compareTo('weak-password') == 0) {
      return S.of(context).too_simple_password;
    } else if (code.compareTo('email-already-in-use') == 0) {
      return S.of(context).this_email_is_already_in_use;
    } else if (code.compareTo('too-many-requests') == 0) {
      return S.of(context).too_many_requests_try_another_time;
    } else if (code.compareTo('unknown-error') == 0) {
      return S.of(context).unknown_error_write_to_support;
    }
    return S.of(context).unknown_error_write_to_support;
  }
}
