import 'package:flutter/material.dart';
import 'package:giphy_search_app/utils/network_checker.dart';

class NetworkStatusBanner extends StatefulWidget {
  const NetworkStatusBanner({super.key});

  @override
  State<NetworkStatusBanner> createState() => _NetworkStatusBannerState();
}

class _NetworkStatusBannerState extends State<NetworkStatusBanner> {
  final NetworkChecker _networkChecker = NetworkChecker();
  bool _isConnected = true;

  @override
  void initState() {
    super.initState();
    _networkChecker.onConnectivityChanged.listen((connected) {
      if (mounted && connected != _isConnected) {
        setState(() {
          _isConnected = connected;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: _isConnected ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _isConnected ? "Connected" : "Disconnected",
        style: const TextStyle(fontSize: 12 ,color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
