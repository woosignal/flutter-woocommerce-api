// To parse this JSON data, do
//
//     final apiData = apiDataFromJson(jsonString);

import 'dart:convert';

List<ApiData> apiDataFromJson(String str) =>
    List<ApiData>.from(json.decode(str).map((x) => ApiData.fromJson(x)));

String apiDataToJson(List<ApiData> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ApiData {
  ApiData({
    this.slug,
    this.description,
    this.links,
  });

  String slug;
  String description;
  Links links;

  factory ApiData.fromJson(Map<String, dynamic> json) => ApiData(
        slug: json["slug"],
        description: json["description"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "description": description,
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
