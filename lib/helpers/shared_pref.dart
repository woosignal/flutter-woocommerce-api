// Copyright (c) 2021, WooSignal Ltd.
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

import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dart:core';
import 'dart:math';

Future<String?> getUserApiKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("DEFAULT_WOOSIGNAL_KEY");
}

Future<void> storeUserApiKey(String apiKey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("DEFAULT_WOOSIGNAL_KEY", apiKey);
}

Future<String?> getUUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uuid = prefs.getString("DEFAULT_WOOSIGNAL_UUID");
  return uuid;
}

storeUUID(String uuid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("DEFAULT_WOOSIGNAL_UUID", uuid.toString());
}

String buildUUID() {
  var uuid = new Uuid();
  String idD = uuid.v1();
  return idD + "_" + randomStr(5);
}

String randomStr(int strLen) {
  const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strLen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}
