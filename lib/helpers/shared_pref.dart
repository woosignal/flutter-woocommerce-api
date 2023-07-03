// Copyright (c) 2023, WooSignal Ltd.
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

Future<String?> getUUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? uuid = prefs.getString("DEFAULT_WOOSIGNAL_UUID");

  if (uuid == null) {
    String uuId = _buildUUID();
    await _storeUUID(uuId);
    return uuId;
  }

  return uuid;
}

_storeUUID(String uuid) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString("DEFAULT_WOOSIGNAL_UUID", uuid.toString());
}

String _buildUUID() {
  var uuid = Uuid();
  String idD = uuid.v1();
  return "${idD}_${_randomStr(5)}";
}

String _randomStr(int strLen) {
  const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  Random rnd = Random(DateTime.now().millisecondsSinceEpoch);
  String result = "";
  for (var i = 0; i < strLen; i++) {
    result += chars[rnd.nextInt(chars.length)];
  }
  return result;
}
