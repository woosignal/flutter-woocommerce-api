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

class Countries {
  Countries({
    this.code,
    this.name,
    this.states,
    this.links,
  });

  String? code;
  String? name;
  List<State>? states;
  Links? links;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        code: json["code"],
        name: json["name"],
        states: List<State>.from(json["states"].map((x) => State.fromJson(x))),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "states": List<dynamic>.from(states!.map((x) => x.toJson())),
        "_links": links!.toJson(),
      };
}

class State {
  State({
    this.code,
    this.name,
  });

  String? code;
  String? name;

  factory State.fromJson(Map<String, dynamic> json) => State(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}
