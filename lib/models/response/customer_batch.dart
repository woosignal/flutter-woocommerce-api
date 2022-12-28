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

class CustomerBatch {
  CustomerBatch({
    this.create,
    this.update,
    this.delete,
  });
  List<Customers>? create;
  List<Customers>? update;
  List<Customers>? delete;

  factory CustomerBatch.fromJson(Map<String, dynamic> json) => CustomerBatch(
        create: List<Customers>.from(
            json["create"].map((x) => Customers.fromJson(x))),
        update: List<Customers>.from(
            json["update"].map((x) => Customers.fromJson(x))),
        delete: List<Customers>.from(
            json["delete"].map((x) => Customers.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "create": List<dynamic>.from(create!.map((x) => x.toJson())),
        "update": List<dynamic>.from(update!.map((x) => x.toJson())),
        "delete": List<dynamic>.from(delete!.map((x) => x.toJson())),
      };
}

class Customers {
  Customers({
    this.id,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.email,
    this.firstName,
    this.lastName,
    this.role,
    this.username,
    this.billing,
    this.shipping,
    this.isPayingCustomer,
    this.avatarUrl,
    this.metaData,
    this.links,
  });

  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? email;
  String? firstName;
  String? lastName;
  String? role;
  String? username;
  Ing? billing;
  Ing? shipping;
  bool? isPayingCustomer;
  String? avatarUrl;
  List<dynamic>? metaData;
  Links? links;

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
        id: json["id"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        email: json["email"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        role: json["role"],
        username: json["username"],
        billing: Ing.fromJson(json["billing"]),
        shipping: Ing.fromJson(json["shipping"]),
        isPayingCustomer: json["is_paying_customer"],
        avatarUrl: json["avatar_url"],
        metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date_created": dateCreated!.toIso8601String(),
        "date_created_gmt": dateCreatedGmt!.toIso8601String(),
        "date_modified": dateModified!.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt!.toIso8601String(),
        "email": email,
        "first_name": firstName,
        "last_name": lastName,
        "role": role,
        "username": username,
        "billing": billing!.toJson(),
        "shipping": shipping!.toJson(),
        "is_paying_customer": isPayingCustomer,
        "avatar_url": avatarUrl,
        "meta_data": List<dynamic>.from(metaData!.map((x) => x)),
        "_links": links!.toJson(),
      };
}

class Ing {
  Ing({
    this.firstName,
    this.lastName,
    this.company,
    this.address1,
    this.address2,
    this.city,
    this.state,
    this.postcode,
    this.country,
    this.email,
    this.phone,
  });

  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  factory Ing.fromJson(Map<String, dynamic> json) => Ing(
        firstName: json["first_name"],
        lastName: json["last_name"],
        company: json["company"],
        address1: json["address_1"],
        address2: json["address_2"],
        city: json["city"],
        state: json["state"],
        postcode: json["postcode"],
        country: json["country"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "company": company,
        "address_1": address1,
        "address_2": address2,
        "city": city,
        "state": state,
        "postcode": postcode,
        "country": country,
        "email": email,
        "phone": phone,
      };
}
