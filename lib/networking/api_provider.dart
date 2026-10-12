// Copyright (c) 2026, WooSignal Ltd.
// All rights reserved.
//
// Redistribution and use in source and binary forms are permitted
// provided that the above copyright notice and this paragraph are
// duplicated in all such forms and that any documentation,
// advertising materials, and other materials related to such
// distribution and use acknowledge that the software was developed
// by the WooSignal. The name of the
// WooSignal may not be used to endorse or promote products derived
// from this software without specific prior written permission.
// THIS SOFTWARE IS PROVIDED ``AS IS'' AND WITHOUT ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.

import 'dart:convert';
import 'package:device_meta/device_meta.dart';
import 'package:dio/dio.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart'
    show debugPrint, kIsWeb, visibleForTesting;

class ApiProvider {
  static const String defaultBaseUrl = "https://api.woosignal.com/v3";

  /// HTTP header that carries the logged in customer's wp_json_api token.
  static const String wpUserTokenHeader = "X-WS-User-Token";

  late Dio _dio;
  bool _isDioReady = false;
  bool _debugMode;
  String? _wpUserToken;
  late final String _apiKey;
  late final String _apiBaseUrl;
  late final String _version;
  Map<String, dynamic> _deviceMeta = {};

  /// Set the device meta
  Future<void> setDeviceMeta() async {
    if (kIsWeb) {
      _deviceMeta = {
        "model": 'X Model',
        "brand": 'X Brand',
        "manufacturer": "X Manufacturer",
        "version": 'X Version',
        "uuid": '1234567890',
        "platform_type": "web",
        "api_version": "$_version/v1",
        "sdk_name": "woosignal-woocommerce"
      };
      return;
    }

    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      _deviceMeta = {
        "model": 'X Model',
        "brand": 'X Brand',
        "manufacturer": "X Manufacturer",
        "version": 'X Version',
        "uuid": '1234567890',
        "platform_type": "testing",
        "api_version": "$_version/v1",
        "sdk_name": "woosignal-woocommerce"
      };
      return;
    }

    DeviceMeta deviceMeta =
        await DeviceMeta.init(storageKey: "woosignal_woocommerce");
    _deviceMeta = {
      "model": deviceMeta.model,
      "brand": deviceMeta.brand,
      "manufacturer": deviceMeta.manufacturer,
      "version": deviceMeta.version,
      "uuid": deviceMeta.uuid,
      "platform_type": deviceMeta.platformType,
      "api_version": "$_version/v1",
      "sdk_name": "woosignal-woocommerce"
    };
  }

  /// set the WP user id
  void setWpUserId(String wpUserId) {
    _deviceMeta['wp_user_id'] = wpUserId;
    _setDioHeaders();
  }

  /// Set the logged in customer's wp_json_api token.
  ///
  /// The token is sent in the [wpUserTokenHeader] header on every request so
  /// WooSignal can verify which customer is asking. Pass null or an empty
  /// string to clear it, e.g. when the customer logs out.
  void setWpUserToken(String? token) {
    String? trimmed = token?.trim();
    _wpUserToken = (trimmed == null || trimmed.isEmpty) ? null : trimmed;
    if (_isDioReady) {
      _setDioHeaders();
    }
  }

  /// Whether a customer's wp_json_api token is set.
  bool get hasWpUserToken => _wpUserToken != null;

  /// The underlying [Dio] client, exposed for tests.
  @visibleForTesting
  Dio get dio => _dio;

  /// set the FCM token
  void setFcmToken(String token) {
    if (_deviceMeta.containsKey('fcm_token')) {
      _deviceMeta['fcm_token'] = token;
    } else {
      _deviceMeta.addAll({"fcm_token": token});
    }
    _setDioHeaders();
  }

  /// set the [ApiProvider]'s debugMode
  void setDebugMode(bool debugMode) {
    _debugMode = debugMode;
  }

  /// Init Dio class
  void _initDio() {
    BaseOptions options = BaseOptions(baseUrl: _apiBaseUrl);
    _dio = Dio(options);
    _isDioReady = true;
  }

  /// Set the http headers for Dio
  void _setDioHeaders() {
    Map<String, dynamic> headers = {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json",
      "X-DMETA": json.encode(_deviceMeta).toString()
    };
    String? wpUserToken = _wpUserToken;
    if (wpUserToken != null) {
      headers[wpUserTokenHeader] = wpUserToken;
    }
    _dio.options.headers = headers;
  }

  /// Constructor requires a [appKey] from WooSignal
  ApiProvider(
      {required String appKey,
      String apiBaseUrl = defaultBaseUrl,
      required String version,
      bool debugMode = true})
      : _apiKey = appKey,
        _apiBaseUrl = apiBaseUrl,
        _debugMode = debugMode,
        _version = version;

  /// Initialize class
  Future init() async {
    _initDio();
    await setDeviceMeta();
    _setDioHeaders();
  }

  /// Print to the console with a [log] response
  void _printLog(String log) {
    if (_debugMode == true) {
      debugPrint("WOOSIGNAL LOG: $log");
    }
  }

  /// HTTP POST request using a [url] and [data] payload
  Future<dynamic> post(String url, data) async {
    try {
      Response response =
          await _dio.post(url, data: {"data": json.encode(data)});
      return response.data;
    } catch (error, stacktrace) {
      _printLog("$error stackTrace: $stacktrace");
      return null;
    }
  }

  /// HTTP GET request using a [url]
  Future<dynamic> get(String url, {dynamic data}) async {
    try {
      Response response = await _dio.get(url, data: data);
      return response.data;
    } catch (error, stacktrace) {
      _printLog("$error stackTrace: $stacktrace");
      return null;
    }
  }
}
