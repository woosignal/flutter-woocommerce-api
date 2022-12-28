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

class TopSellerReport {
  TopSellerReport({
    this.title,
    this.productId,
    this.quantity,
    this.links,
  });

  String? title;
  int? productId;
  int? quantity;
  Links? links;

  factory TopSellerReport.fromJson(Map<String, dynamic> json) =>
      TopSellerReport(
        title: json["title"],
        productId: json["product_id"],
        quantity: json["quantity"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "product_id": productId,
        "quantity": quantity,
        "_links": links!.toJson(),
      };
}

class Links {
  Links({
    this.about,
    this.product,
  });

  List<About>? about;
  List<About>? product;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        product:
            List<About>.from(json["product"].map((x) => About.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "about": List<dynamic>.from(about!.map((x) => x.toJson())),
        "product": List<dynamic>.from(product!.map((x) => x.toJson())),
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
