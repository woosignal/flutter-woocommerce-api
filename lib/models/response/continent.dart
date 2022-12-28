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

class Continents {
  Continents({
    this.code,
    this.name,
    this.countries,
    this.links,
  });

  String? code;
  String? name;
  List<Country>? countries;
  Links? links;

  Continents.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    name = json["name"];
    countries =
        List<Country>.from(json["countries"].map((x) => Country.fromJson(x)));
    links = Links.fromJson(json["_links"]);
  }

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "countries": List<dynamic>.from(countries!.map((x) => x.toJson())),
        "_links": links!.toJson(),
      };
}

class Country {
  Country({
    this.code,
    this.name,
    this.states,
    this.currencyCode,
    this.currencyPos,
    this.decimalSep,
    this.dimensionUnit,
    this.numDecimals,
    this.thousandSep,
    this.weightUnit,
  });

  String? code;
  String? name;
  List<State>? states;
  String? currencyCode;
  CurrencyPos? currencyPos;
  Sep? decimalSep;
  DimensionUnit? dimensionUnit;
  int? numDecimals;
  Sep? thousandSep;
  WeightUnit? weightUnit;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        code: json["code"],
        name: json["name"],
        states: List<State>.from(json["states"].map((x) => State.fromJson(x))),
        currencyCode: json["currency_code"],
        currencyPos: json["currency_pos"] == null
            ? null
            : currencyPosValues.map[json["currency_pos"]],
        decimalSep: json["decimal_sep"] == null
            ? null
            : sepValues.map[json["decimal_sep"]],
        dimensionUnit: json["dimension_unit"] == null
            ? null
            : dimensionUnitValues.map[json["dimension_unit"]],
        numDecimals: json["num_decimals"],
        thousandSep: json["thousand_sep"] == null
            ? null
            : sepValues.map[json["thousand_sep"]],
        weightUnit: json["weight_unit"] == null
            ? null
            : weightUnitValues.map[json["weight_unit"]],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "states": List<dynamic>.from(states!.map((x) => x.toJson())),
        "currency_code": currencyCode,
        "currency_pos": currencyPos == null
            ? null
            : currencyPosValues.reverse![currencyPos!],
        "decimal_sep":
            decimalSep == null ? null : sepValues.reverse![decimalSep!],
        "dimension_unit": dimensionUnit == null
            ? null
            : dimensionUnitValues.reverse![dimensionUnit!],
        "num_decimals": numDecimals,
        "thousand_sep":
            thousandSep == null ? null : sepValues.reverse![thousandSep!],
        "weight_unit":
            weightUnit == null ? null : weightUnitValues.reverse![weightUnit!],
      };
}

enum CurrencyPos { left, leftSpace, right, rightSpace }

final currencyPosValues = EnumValues({
  "left": CurrencyPos.left,
  "left_space": CurrencyPos.leftSpace,
  "right": CurrencyPos.right,
  "right_space": CurrencyPos.rightSpace
});

enum Sep { empty, sep, purple }

final sepValues = EnumValues({".": Sep.empty, " ": Sep.purple, ",": Sep.sep});

enum DimensionUnit { cm, inch }

final dimensionUnitValues =
    EnumValues({"cm": DimensionUnit.cm, "in": DimensionUnit.inch});

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

enum WeightUnit { kg, oz }

final weightUnitValues = EnumValues({"kg": WeightUnit.kg, "oz": WeightUnit.oz});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
