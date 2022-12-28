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

class SettingOptionBatch {
  SettingOptionBatch({
    this.update,
  });

  List<Update>? update;

  factory SettingOptionBatch.fromJson(Map<String, dynamic> json) =>
      SettingOptionBatch(
        update:
            List<Update>.from(json["update"].map((x) => Update.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "update": List<dynamic>.from(update!.map((x) => x.toJson())),
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

  String? id;
  String? label;
  String? description;
  String? type;
  String? updateDefault;
  Map<String, String>? options;
  String? tip;
  String? value;
  Links? links;

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
        tip: json["tip"],
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
            : Map.from(options!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "tip": tip,
        "value": value,
        "_links": links!.toJson(),
      };
}
