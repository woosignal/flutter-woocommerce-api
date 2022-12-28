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

import 'package:woosignal/models/links.dart';

class CustomerDownload {
  String? downloadId;
  String? downloadUrl;
  int? productId;
  String? productName;
  String? downloadName;
  int? orderId;
  String? orderKey;
  String? downloadsRemaining;
  String? accessExpires;
  String? accessExpiresGmt;
  File? file;
  Links? links;

  CustomerDownload(
      {this.downloadId,
      this.downloadUrl,
      this.productId,
      this.productName,
      this.downloadName,
      this.orderId,
      this.orderKey,
      this.downloadsRemaining,
      this.accessExpires,
      this.accessExpiresGmt,
      this.file,
      this.links});

  CustomerDownload.fromJson(Map<String, dynamic> json) {
    downloadId = json['download_id'];
    downloadUrl = json['download_url'];
    productId = json['product_id'];
    productName = json['product_name'];
    downloadName = json['download_name'];
    orderId = json['order_id'];
    orderKey = json['order_key'];
    downloadsRemaining = json['downloads_remaining'];
    accessExpires = json['access_expires'];
    accessExpiresGmt = json['access_expires_gmt'];
    file = json['file'] != null ? File.fromJson(json['file']) : null;
    links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['download_id'] = downloadId;
    data['download_url'] = downloadUrl;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['download_name'] = downloadName;
    data['order_id'] = orderId;
    data['order_key'] = orderKey;
    data['downloads_remaining'] = downloadsRemaining;
    data['access_expires'] = accessExpires;
    data['access_expires_gmt'] = accessExpiresGmt;
    if (file != null) {
      data['file'] = file!.toJson();
    }
    if (links != null) {
      data['_links'] = links!.toJson();
    }
    return data;
  }
}

class File {
  String? name;
  String? file;

  File({this.name, this.file});

  File.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    file = json['file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['file'] = file;
    return data;
  }
}
