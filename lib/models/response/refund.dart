// Copyright (c) 2025, WooSignal Ltd.
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

class Refund {
  Refund({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.amount,
    this.reason,
    this.refundedBy,
    this.refundedPayment,
    this.metaData,
    this.lineItems,
    this.links,
  });

  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  String? amount;
  String? reason;
  int? refundedBy;
  bool? refundedPayment;
  List<dynamic>? metaData;
  List<dynamic>? lineItems;
  Links? links;

  factory Refund.fromJson(Map<String, dynamic> json) => Refund(
        id: json["id"],
        dateCreated: json["date_created"] != null
            ? DateTime.tryParse(json["date_created"])
            : null,
        dateCreatedGmt: json["date_created_gmt"] != null
            ? DateTime.tryParse(json["date_created_gmt"])
            : null,
        amount: json["amount"],
        reason: json["reason"],
        refundedBy: json["refunded_by"],
        refundedPayment: json["refunded_payment"],
        metaData: json["meta_data"] != null
            ? List<dynamic>.from(json["meta_data"].map((x) => x))
            : null,
        lineItems: json["line_items"] != null
            ? List<dynamic>.from(json["line_items"].map((x) => x))
            : null,
        links:
            json["_links"] != null ? Links.fromJson(json["_links"]) : null,
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (dateCreated != null) {
      data['date_created'] = dateCreated!.toIso8601String();
    }
    if (dateCreatedGmt != null) {
      data['date_created_gmt'] = dateCreatedGmt!.toIso8601String();
    }
    data['amount'] = amount;
    data['reason'] = reason;
    data['refunded_by'] = refundedBy;
    data['refunded_payment'] = refundedPayment;
    if (metaData != null) {
      data['meta_data'] = List<dynamic>.from(metaData!.map((x) => x));
    }
    if (lineItems != null) {
      data['line_items'] = List<dynamic>.from(lineItems!.map((x) => x));
    }
    if (links != null) {
      data['_links'] = links!.toJson();
    }
    return data;
  }
}
