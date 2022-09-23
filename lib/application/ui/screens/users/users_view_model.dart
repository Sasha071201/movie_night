import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/domain/entities/user.dart';
import 'package:movie_night/application/repository/account_repository.dart';

class UsersViewModel extends ChangeNotifier {
  final _accountRepository = AccountRepository();

  Stream<List<User>>? users;
  Timer? _debounce;
  String _previousAsyncSearchText = '';

  final FocusNode focusNode = FocusNode();
  final TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  bool canCancel = false;

  void init() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        canCancel = true;
        notifyListeners();
      } else {
        canCancel = false;
        _debounce?.cancel();
        notifyListeners();
      }
    });
    searchController.addListener(() async {
      final text = searchController.text.trim();
      if (text.isNotEmpty) {
        updateSuggestions(text);
      } else {
        _previousAsyncSearchText = '';
        isLoading = false;
        users = null;
        notifyListeners();
      }
      notifyListeners();
    });
  }

  void updateSuggestions(String text) async {
    _debounce?.cancel();
    isLoading = focusNode.hasFocus ? true : false;
    notifyListeners();
    _debounce = Timer(const Duration(milliseconds: 1000), () async {
      final searchText = text.isNotEmpty ? text : null;
      if (searchText == _previousAsyncSearchText) {
        isLoading = false;
        notifyListeners();
        return;
      }
      isLoading = true;
      notifyListeners();

      users = _accountRepository.usersStream(text);
      _previousAsyncSearchText = text;
      isLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    searchController.dispose();
    super.dispose();
  }
}
