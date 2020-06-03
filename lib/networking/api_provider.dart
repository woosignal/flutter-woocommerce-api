// Copyright (c) 2020, WooSignal Ltd.
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
import 'package:dio/dio.dart';
import 'package:woosignal/helpers/shared_pref.dart';
import 'package:device_info/device_info.dart';
import 'package:woosignal/env.dart';
import 'dart:io' show Platform;

class ApiProvider {
  Dio _dio;
  Future _doneFuture;

  Future<DeviceInfoPlugin> userDeviceInfo;
  Map<String, dynamic> deviceMeta = {};

  Future get initializationDone => _doneFuture;

  Future<void> _setDeviceMeta() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String uuid;
    await getUUID().then((val) {
      if (val == null) {
        String uid = buildUUID();
        storeUUID(uid);
        uuid = uid;
      } else {
        uuid = val;
      }
    });

    if (Platform.isAndroid) {
      await deviceInfo.androidInfo.then((androidMeta) {
        deviceMeta = {
          "model": androidMeta.device,
          "brand":
              androidMeta.brand.replaceAll(new RegExp('[^\u0001-\u007F]'), '_'),
          "manufacturer": androidMeta.manufacturer,
          "version": androidMeta.version.baseOS,
          "uuid": uuid
        };
      });
    } else if (Platform.isIOS) {
      await deviceInfo.iosInfo.then((iosMeta) {
        deviceMeta = {
          "model": iosMeta.model,
          "brand": iosMeta.name.replaceAll(new RegExp('[^\u0001-\u007F]'), '_'),
          "manufacturer": "Apple",
          "version": iosMeta.systemVersion,
          "uuid": uuid
        };
      });
    }
  }

  Future<void> _setHeaderAPI() async {
    await getUserApiKey().then((apiToken) {
      if (apiToken != null) {
        BaseOptions options = new BaseOptions(baseUrl: baseUrl, headers: {
          "Authorization": "Bearer " + apiToken,
          "Content-Type": "application/json",
          "X-DMETA": json.encode(deviceMeta).toString()
        });
        this._dio = new Dio(options);
      }
    });
  }

  ApiProvider() {
    _doneFuture = _init();
  }

  Future _init() async {
    await _setDeviceMeta();
    await _setHeaderAPI();
  }

  void _printLog(String log) {
    print("WOOSIGNAL LOG: $log");
  }

  // POST
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
}
