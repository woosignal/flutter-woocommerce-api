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

  String? id;
  String? label;
  String? description;
  String? type;
  String? settingOptionDefault;
  String? tip;
  String? value;
  Links? links;
  Map<String, String>? options;

  factory SettingOption.fromJson(Map<String, dynamic> json) => SettingOption(
        id: json["id"],
        label: json["label"],
        description: json["description"],
        type: json["type"],
        settingOptionDefault: json["default"],
        tip: json["tip"],
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
        "tip": tip,
        "value": value,
        "_links": links!.toJson(),
        "options": options == null
            ? null
            : Map.from(options!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}
