import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/domain/api_client/api_client_exception.dart';
import 'package:movie_night/application/repository/auth_repository.dart';
import 'package:movie_night/application/ui/navigation/app_navigation.dart';

import '../../../repository/account_repository.dart';
import '../../widgets/dialog_widget.dart';

class ProfileViewModel extends ChangeNotifier {
  final _authRepository = AuthRepository();
  final _accountRepository = AccountRepository();
  var isLoadingProgress = false;
  StreamSubscription? _streamSubscription;
  Timer? _timer;
  String nameFromDB = '';
  String profileImageUrl = '';

  ProfileViewModel() {
    _streamSubscription?.cancel();
    _streamSubscription = _accountRepository.userStream().listen((event) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    isLoadingProgress = true;
    Future.microtask(() => notifyListeners());
    _timer?.cancel();
    _timer = Timer(
      const Duration(milliseconds: 5000),
      () async {
        final name = await _accountRepository.fetchUserName();
        nameFromDB = name;
        profileImageUrl = await _accountRepository.fetchUserProfileImageUrl();
        isLoadingProgress = false;
        Future.microtask(() => notifyListeners());
      },
    );
  }

  Future<void> openAboutMe(BuildContext context) async {
    Navigator.of(context).pushNamed(Screens.aboutMe);
  }

  Future<void> openSubscription(BuildContext context) async {
    Navigator.of(context).pushNamed(Screens.subscription);
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _authRepository.signOut();
    } on ApiClientException catch (e) {
      _showDialog(context, e.asString(context));
    } 
  }

  void _showDialog(BuildContext context, String errorMessage) {
    DialogWidget.showSnackBar(
      context: context,
      duration: const Duration(seconds: 3),
      text: errorMessage,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _streamSubscription?.cancel();
    _streamSubscription = null;
    super.dispose();
  }
}
