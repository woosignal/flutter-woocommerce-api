// To parse this JSON data, do
//
//     final settingOptionBatch = settingOptionBatchFromJson(jsonString);

import 'dart:convert';

SettingOptionBatch settingOptionBatchFromJson(String str) =>
    SettingOptionBatch.fromJson(json.decode(str));

String settingOptionBatchToJson(SettingOptionBatch data) =>
    json.encode(data.toJson());

class SettingOptionBatch {
  SettingOptionBatch({
    this.update,
  });

  List<Update> update;

  factory SettingOptionBatch.fromJson(Map<String, dynamic> json) =>
      SettingOptionBatch(
        update:
            List<Update>.from(json["update"].map((x) => Update.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "update": List<dynamic>.from(update.map((x) => x.toJson())),
      };
}

class Update {
  Update({
    this.id,
    this.label,
    this.description,
    this.type,
    this.updateDefault,
    this.options,
    this.tip,
    this.value,
    this.links,
  });

  String id;
  String label;
  String description;
  String type;
  String updateDefault;
  Map<String, String> options;
  String tip;
  String value;
  Links links;

  factory Update.fromJson(Map<String, dynamic> json) => Update(
        id: json["id"],
        label: json["label"],
        description: json["description"],
        type: json["type"],
        updateDefault: json["default"],
        options: json["options"] == null
            ? null
            : Map.from(json["options"])
                .map((k, v) => MapEntry<String, String>(k, v)),
        tip: json["tip"] == null ? null : json["tip"],
        value: json["value"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "description": description,
        "type": type,
        "default": updateDefault,
        "options": options == null
            ? null
            : Map.from(options).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "tip": tip == null ? null : tip,
        "value": value,
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
