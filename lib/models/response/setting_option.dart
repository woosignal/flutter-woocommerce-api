// To parse this JSON data, do
//
//     final settingOption = settingOptionFromJson(jsonString);

import 'dart:convert';

List<SettingOption> settingOptionFromJson(String str) =>
    List<SettingOption>.from(
        json.decode(str).map((x) => SettingOption.fromJson(x)));

String settingOptionToJson(List<SettingOption> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SettingOption {
  SettingOption({
    this.id,
    this.label,
    this.description,
    this.type,
    this.settingOptionDefault,
    this.tip,
    this.value,
    this.links,
    this.options,
  });

  String id;
  String label;
  String description;
  String type;
  String settingOptionDefault;
  String tip;
  String value;
  Links links;
  Map<String, String> options;

  factory SettingOption.fromJson(Map<String, dynamic> json) => SettingOption(
        id: json["id"],
        label: json["label"],
        description: json["description"],
        type: json["type"],
        settingOptionDefault: json["default"],
        tip: json["tip"] == null ? null : json["tip"],
        value: json["value"],
        links: Links.fromJson(json["_links"]),
        options: json["options"] == null
            ? null
            : Map.from(json["options"])
                .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "description": description,
        "type": type,
        "default": settingOptionDefault,
        "tip": tip == null ? null : tip,
        "value": value,
        "_links": links.toJson(),
        "options": options == null
            ? null
            : Map.from(options).map((k, v) => MapEntry<String, dynamic>(k, v)),
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
