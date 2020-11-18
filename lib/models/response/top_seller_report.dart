// To parse this JSON data, do
//
//     final topSellerReport = topSellerReportFromJson(jsonString);

import 'dart:convert';

TopSellerReport topSellerReportFromJson(String str) =>
    TopSellerReport.fromJson(json.decode(str));

String topSellerReportToJson(TopSellerReport data) =>
    json.encode(data.toJson());

class TopSellerReport {
  TopSellerReport({
    this.title,
    this.productId,
    this.quantity,
    this.links,
  });

  String title;
  int productId;
  int quantity;
  Links links;

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
        "_links": links.toJson(),
      };
}

class Links {
  Links({
    this.about,
    this.product,
  });

  List<About> about;
  List<About> product;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        product:
            List<About>.from(json["product"].map((x) => About.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "about": List<dynamic>.from(about.map((x) => x.toJson())),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class About {
  About({
    this.href,
  });

  String href;

  factory About.fromJson(Map<String, dynamic> json) => About(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}
