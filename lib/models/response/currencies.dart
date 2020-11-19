// To parse this JSON data, do
//
//     final currencies = currenciesFromJson(jsonString);

import 'dart:convert';

List<Currencies> currenciesFromJson(String str) =>
    List<Currencies>.from(json.decode(str).map((x) => Currencies.fromJson(x)));

String currenciesToJson(List<Currencies> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Currencies {
  Currencies({
    this.code,
    this.name,
    this.symbol,
    this.links,
  });

  String code;
  String name;
  String symbol;
  Links links;

  factory Currencies.fromJson(Map<String, dynamic> json) => Currencies(
        code: json["code"],
        name: json["name"],
        symbol: json["symbol"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "symbol": symbol,
        "_links": links.toJson(),
      };
}

class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection> self;
  List<Collection> collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        self: List<Collection>.from(
            json["self"].map((x) => Collection.fromJson(x))),
        collection: List<Collection>.from(
            json["collection"].map((x) => Collection.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "self": List<dynamic>.from(self.map((x) => x.toJson())),
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
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
