import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_night/application/domain/connectivity/connectivity_helper.dart';

class AppConnectivityReactor {
  final BuildContext context;
  StreamSubscription? _streamSubscription;

  AppConnectivityReactor({required this.context});

  void listenToConnectivityChanged({
    required void Function() onConnectionYes,
    required void Function() onConnectionNo,
  }) {
    ConnectivityHelper.hasConnectivity().then((value) {
      if (!value) {
        onConnectionNo();
        return;
      }
      onConnectionYes();
    });
    _streamSubscription = ConnectivityHelper.onConnectivityChanged.listen(
      (connectivity) => _onConnectivityChanged(
        connectivity: connectivity,
        onConnectionYes: onConnectionYes,
        onConnectionNo: onConnectionNo,
      ),
    );
  }

  void _onConnectivityChanged({
    required ConnectivityResult connectivity,
    required void Function() onConnectionYes,
    required void Function() onConnectionNo,
  }) {
    if (connectivity == ConnectivityResult.mobile ||
        connectivity == ConnectivityResult.wifi) {
      onConnectionYes();
      return;
    }
    onConnectionNo();
  }

  void dispose() {
    _streamSubscription?.cancel();
    _streamSubscription = null;
  }
}
