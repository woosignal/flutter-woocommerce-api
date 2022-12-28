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

class Reports {
  Reports({
    this.slug,
    this.description,
    this.links,
  });

  String? slug;
  String? description;
  Links? links;

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
        slug: json["slug"],
        description: json["description"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "description": description,
        "_links": links!.toJson(),
      };
}

class About {
  About({
    this.href,
  });

  String? href;

  factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}

class Total {
  Total({
    this.sales,
    this.orders,
    this.items,
    this.tax,
    this.shipping,
    this.discount,
    this.customers,
  });

  String? sales;
  int? orders;
  int? items;
  String? tax;
  String? shipping;
  String? discount;
  int? customers;

  factory Total.fromJson(Map<String, dynamic> json) => Total(
        sales: json["sales"],
        orders: json["orders"],
        items: json["items"],
        tax: json["tax"],
        shipping: json["shipping"],
        discount: json["discount"],
        customers: json["customers"],
      );

  Map<String, dynamic> toJson() => {
        "sales": sales,
        "orders": orders,
        "items": items,
        "tax": tax,
        "shipping": shipping,
        "discount": discount,
        "customers": customers,
      };
}

class TotalReport {
  TotalReport({
    this.slug,
    this.name,
    this.total,
  });

  String? slug;
  String? name;
  int? total;

  factory TotalReport.fromJson(Map<String, dynamic> json) => TotalReport(
        slug: json["slug"],
        name: json["name"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "total": total,
      };
}
