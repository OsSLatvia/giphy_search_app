import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {
  final Connectivity _connectivity = Connectivity();

  /// Check current connectivity status once.
  Future<bool> isConnected() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Stream<bool> get onConnectivityChanged {
    StreamController<bool>? controller;
    Timer? debounceTimer;

    void onData(ConnectivityResult result) {
      // Cancel previous timer if still active
      debounceTimer?.cancel();

      // Start new timer to emit event after delay (800ms here) (needed to not notify multiple succesive times on network change when unstable network, so small delay need)
      debounceTimer = Timer(const Duration(milliseconds: 800), () {
        bool isConnected = result != ConnectivityResult.none;
        controller?.add(isConnected);
      });
    }

    controller = StreamController<bool>.broadcast(
      onListen: () {
        _connectivity.onConnectivityChanged.listen(onData);
      },
      onCancel: () {
        debounceTimer?.cancel();
      },
    );

    return controller.stream;
  }
}
