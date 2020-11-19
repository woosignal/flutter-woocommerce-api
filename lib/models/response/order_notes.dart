// To parse this JSON data, do
//
//     final orderNote = orderNoteFromJson(jsonString);

import 'dart:convert';

OrderNote orderNoteFromJson(String str) => OrderNote.fromJson(json.decode(str));

String orderNoteToJson(OrderNote data) => json.encode(data.toJson());

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

  int id;
  String author;
  DateTime dateCreated;
  DateTime dateCreatedGmt;
  String note;
  bool customerNote;
  Links links;

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
        "date_created": dateCreated.toIso8601String(),
        "date_created_gmt": dateCreatedGmt.toIso8601String(),
        "note": note,
        "customer_note": customerNote,
        "_links": links.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
    this.up,
  });

  List<Collection> self;
  List<Collection> collection;
  List<Collection> up;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
        up: List<Collection>.from(
            json["up"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "up": List<dynamic>.from(up.map((x) => x.toJson())),
      };
}

class Collection {
  Collection({
    this.href,
  });

  String href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}
