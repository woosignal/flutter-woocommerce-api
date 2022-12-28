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

class OrderNote {
  OrderNote({
    this.id,
    this.author,
    this.dateCreated,
    this.dateCreatedGmt,
    this.note,
    this.customerNote,
    this.links,
  });

  int? id;
  String? author;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  String? note;
  bool? customerNote;
  Links? links;

  factory OrderNote.fromJson(Map<String, dynamic> json) => OrderNote(
        id: json["id"],
        author: json["author"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        note: json["note"],
        customerNote: json["customer_note"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "date_created": dateCreated!.toIso8601String(),
        "date_created_gmt": dateCreatedGmt!.toIso8601String(),
        "note": note,
        "customer_note": customerNote,
        "_links": links!.toJson(),
      };
}
