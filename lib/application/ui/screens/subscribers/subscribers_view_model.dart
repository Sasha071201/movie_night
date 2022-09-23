import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/domain/api_client/api_client_exception.dart';
import 'package:movie_night/application/domain/entities/user.dart';
import 'package:movie_night/application/repository/account_repository.dart';
import 'package:movie_night/application/ui/themes/app_colors.dart';
import 'package:movie_night/application/ui/widgets/dialog_widget.dart';

class SubscribersViewModel extends ChangeNotifier {
  final _accountRepository = AccountRepository();

  List<User> subscribers = [];
  String _locale = '';
  late BuildContext _context;
  Timer? _timer;
  bool isLoadingProgress = false;

  final _controllerNeedUpdate = StreamController<bool>();
  StreamSubscription? _streamNeedUpdateSubscription;

  SubscribersViewModel() {
    _listenNeedUpdate();
  }

  Future<void> setupLocale(BuildContext context) async {
    _context = context;
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    await _loadSubscribers();
  }

  void _listenNeedUpdate() {
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = _controllerNeedUpdate.stream.listen((needUpdate) {
      if (needUpdate) {
        _timer?.cancel();
        _timer = Timer(const Duration(seconds: 10), () async {
          await _loadSubscribers();
        });
      }
    });
  }

  Future<void> _loadSubscribers() async {
    if (isLoadingProgress) return;
    isLoadingProgress = true;
    Future.microtask(() => notifyListeners());
    try {
      await _fetchSubscribers();
    } on ApiClientException catch (e) {
      _controllerNeedUpdate.add(true);
      DialogWidget.showSnackBar(
        context: _context,
        text: e.asString(_context),
        backgroundColor: AppColors.colorError,
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    isLoadingProgress = false;
    notifyListeners();
  }

  Future<void> _fetchSubscribers() async {
    final newSubscribers = await _accountRepository.fetchSubscribers();
    final subscribersNewAndOld = List<User>.from(subscribers);
    subscribersNewAndOld.addAll(newSubscribers);
    subscribers = subscribersNewAndOld;
  }

  ///TODO если будет много людей, то переписать с пагинацией как на экранах с фильмами
  // void showedCategoryAtIndex(int index) {
  //   if (index < subscriptions.length - 1) return;
  //   _loadSubscriptions();
  // }

  @override
  void dispose() {
    _timer?.cancel();
    _streamNeedUpdateSubscription?.cancel();
    _streamNeedUpdateSubscription = null;
    super.dispose();
  }
}
