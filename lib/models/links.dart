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

import 'package:woosignal/models/collection.dart';
import 'package:woosignal/models/self.dart';

class Links {
  List<Self>? self;
  List<Collection>? collection;
  List<Collection>? up;
  List<Collection>? describes;

  Links({this.self, this.collection, this.up});

  Links.fromJson(Map<String, dynamic> json) {
    if (json['self'] != null) {
      self = [];
      json['self'].forEach((v) {
        self!.add(Self.fromJson(v));
      });
    }
    if (json['collection'] != null) {
      collection = [];
      json['collection'].forEach((v) {
        collection!.add(Collection.fromJson(v));
      });
    }
    if (json['up'] != null) {
      up = [];
      json['up'].forEach((v) {
        up!.add(Collection.fromJson(v));
      });
    }
    if (json['describes'] != null) {
      describes = [];
      json['describes'].forEach((v) {
        describes!.add(Collection.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (self != null) {
      data['self'] = self!.map((v) => v.toJson()).toList();
    }
    if (collection != null) {
      data['collection'] = collection!.map((v) => v.toJson()).toList();
    }
    if (up != null) {
      data['up'] = up!.map((v) => v.toJson()).toList();
    }
    if (describes != null) {
      data['describes'] = describes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
