// To parse this JSON data, do
//
//     final continents = continentsFromJson(jsonString);

import 'dart:convert';

List<Continents> continentsFromJson(String str) =>
    List<Continents>.from(json.decode(str).map((x) => Continents.fromJson(x)));

String continentsToJson(List<Continents> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Continents {
  Continents({
    this.code,
    this.name,
    this.countries,
    this.links,
  });

  String code;
  String name;
  List<Country> countries;
  Links links;

  factory Continents.fromJson(Map<String, dynamic> json) => Continents(
        code: json["code"],
        name: json["name"],
        countries: List<Country>.from(
            json["countries"].map((x) => Country.fromJson(x))),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
        "countries": List<dynamic>.from(countries.map((x) => x.toJson())),
        "_links": links.toJson(),
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

  String code;
  String name;
  List<State> states;
  String currencyCode;
  CurrencyPos currencyPos;
  Sep decimalSep;
  DimensionUnit dimensionUnit;
  int numDecimals;
  Sep thousandSep;
  WeightUnit weightUnit;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        code: json["code"],
        name: json["name"],
        states: List<State>.from(json["states"].map((x) => State.fromJson(x))),
        currencyCode:
            json["currency_code"] == null ? null : json["currency_code"],
        currencyPos: json["currency_pos"] == null
            ? null
            : currencyPosValues.map[json["currency_pos"]],
        decimalSep: json["decimal_sep"] == null
            ? null
            : sepValues.map[json["decimal_sep"]],
        dimensionUnit: json["dimension_unit"] == null
            ? null
            : dimensionUnitValues.map[json["dimension_unit"]],
        numDecimals: json["num_decimals"] == null ? null : json["num_decimals"],
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
        "states": List<dynamic>.from(states.map((x) => x.toJson())),
        "currency_code": currencyCode == null ? null : currencyCode,
        "currency_pos":
            currencyPos == null ? null : currencyPosValues.reverse[currencyPos],
        "decimal_sep":
            decimalSep == null ? null : sepValues.reverse[decimalSep],
        "dimension_unit": dimensionUnit == null
            ? null
            : dimensionUnitValues.reverse[dimensionUnit],
        "num_decimals": numDecimals == null ? null : numDecimals,
        "thousand_sep":
            thousandSep == null ? null : sepValues.reverse[thousandSep],
        "weight_unit":
            weightUnit == null ? null : weightUnitValues.reverse[weightUnit],
      };
}

enum CurrencyPos { LEFT, LEFT_SPACE, RIGHT, RIGHT_SPACE }

final currencyPosValues = EnumValues({
  "left": CurrencyPos.LEFT,
  "left_space": CurrencyPos.LEFT_SPACE,
  "right": CurrencyPos.RIGHT,
  "right_space": CurrencyPos.RIGHT_SPACE
});

enum Sep { EMPTY, SEP, PURPLE }

final sepValues = EnumValues({".": Sep.EMPTY, " ": Sep.PURPLE, ",": Sep.SEP});

enum DimensionUnit { CM, IN }

final dimensionUnitValues =
    EnumValues({"cm": DimensionUnit.CM, "in": DimensionUnit.IN});

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

enum WeightUnit { KG, OZ }

final weightUnitValues = EnumValues({"kg": WeightUnit.KG, "oz": WeightUnit.OZ});

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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
