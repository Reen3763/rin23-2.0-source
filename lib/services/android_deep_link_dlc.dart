import 'dart:io';
import 'package:flutter/services.dart';

class DeepLinkService {
  static const MethodChannel _channel = MethodChannel(
    'com.rin23.next/deeplink',
  );

  static final DeepLinkService _instance = DeepLinkService._internal();
  factory DeepLinkService() => _instance;
  DeepLinkService._internal();

  Function(String uuid)? _onDeepLinkReceived;
  bool _isInitialized = false;

  void initialize({required Function(String uuid) onDeepLinkReceived}) {
    if (!Platform.isAndroid) {
      return;
    }

    // Prevent double initialization
    if (_isInitialized) return;
    _isInitialized = true;

    _onDeepLinkReceived = onDeepLinkReceived;

    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onDeepLink') {
        _handleDeepLink(call.arguments);
      }
    });
  }

  void _handleDeepLink(dynamic arguments) {
    if (arguments is Map) {
      final uuid = arguments['uuid'] as String?;
      if (uuid != null && _onDeepLinkReceived != null) {
        _onDeepLinkReceived!(uuid);
      }
    }
  }

  void dispose() {
    _onDeepLinkReceived = null;
    _isInitialized = false;
  }
}
