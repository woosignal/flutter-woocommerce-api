// Copyright (c) 2024, WooSignal Ltd.
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
import 'package:flutter/foundation.dart' show kIsWeb;

class ApiProvider {
  late Dio _dio;
  bool _debugMode;
  late final String _apiKey;
  late final String _version;
  Map<String, dynamic> _deviceMeta = {};

  /// Set the device meta
  Future<void> setDeviceMeta() async {
    DeviceMeta deviceMeta =
        await DeviceMeta.init(storageKey: "woosignal_woocommerce");

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
  _initDio() {
    BaseOptions options = BaseOptions(baseUrl: "https://api.woosignal.com/v3");
    _dio = Dio(options);
  }

  /// Set the http headers for Dio
  _setDioHeaders() {
    _dio.options.headers = {
      "Authorization": "Bearer $_apiKey",
      "Content-Type": "application/json",
      "X-DMETA": json.encode(_deviceMeta).toString()
    };
  }

  /// Constructor requires a [appKey] from WooSignal
  ApiProvider(
      {required String appKey, required String version, bool debugMode = true})
      : _apiKey = appKey,
        _debugMode = debugMode,
        _version = version;

  /// Initialize class
  Future init() async {
    _initDio();
    await setDeviceMeta();
    await _setDioHeaders();
  }

  /// Print to the console with a [log] response
  void _printLog(String log) {
    if (_debugMode == true) {
      print("WOOSIGNAL LOG: $log");
    }
  }

  /// HTTP POST request using a [url] and [data] payload
  Future<dynamic> post(url, data) async {
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
  Future<dynamic> get(url, {dynamic data}) async {
    try {
      Response response = await _dio.get(url, data: data);
      return response.data;
    } catch (error, stacktrace) {
      _printLog("$error stackTrace: $stacktrace");
      return null;
    }
  }
}
