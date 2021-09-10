import 'dart:async';

import 'package:flutter/services.dart';

class HerowPluginFlutter {
  static const MethodChannel _channel = const MethodChannel('herow.io/sdk');

  static Future get customId async {
    return _channel.invokeMethod('getCustomId');
  }

  static Future<void> setCustomId(String customId) async {
    _channel.invokeMethod('setCustomId', {"customId": customId});
  }

  static Future<void> initialize(
      String herowPlatform, String apikey, String secret) async {
    _channel.invokeMethod("configApp",
        {"herowPlatform": herowPlatform, "apiKey": apikey, "secret": secret});
  }

  static Future<void> removeCustomId() async {
    _channel.invokeMethod("removeCustomId");
  }

  static Future getOptin() async {
    return _channel.invokeMethod("getOptin");
  }

  static Future<void> acceptOptin() async {
    _channel.invokeMethod("acceptOptin");
  }

  static Future<void> refuseOptin() async {
    _channel.invokeMethod("refuseOptin");
  }

  static Future<void> askLocationPermission() async {
    _channel.invokeMethod("askLocation");
  }

  static Future<void> askNotificationPermission() async {
    _channel.invokeMethod("askNotification");
  }

  static Future<void> askIDFAPermission() async {
    _channel.invokeMethod("askIDFA");
  }

  static Future<void> launchClickAndCollect() async {
    _channel.invokeMethod("launchClickAndCollect");
  }

  static Future<void> stopClickAndCollect() async {
    _channel.invokeMethod("stopClickAndCollect");
  }

  static Future isOnClickAndCollect() async {
    return _channel.invokeMethod("isOnClickAndCollect");
  }

  static Future<void> reset(
      String sdkId, String sdkKey, String customId) async {
    _channel.invokeMethod(
        "configApp", {"sdkId": sdkId, "sdkKey": sdkKey, "customId": customId});
  }
}
