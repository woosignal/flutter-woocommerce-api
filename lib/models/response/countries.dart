// To parse this JSON data, do
//
//     final countries = countriesFromJson(jsonString);

import 'dart:convert';

List<Countries> countriesFromJson(String str) =>
    List<Countries>.from(json.decode(str).map((x) => Countries.fromJson(x)));

String countriesToJson(List<Countries> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Countries {
  Countries({
    this.code,
    this.name,
    this.states,
    this.links,
  });

  String code;
  String name;
  List<State> states;
  Links links;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        code: json["code"],
        name: json["name"],
        states: List<State>.from(json["states"].map((x) => State.fromJson(x))),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
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

class State {
  State({
    this.code,
    this.name,
  });

  String code;
  String name;

  factory State.fromJson(Map<String, dynamic> json) => State(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}
