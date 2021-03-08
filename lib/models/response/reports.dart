// Copyright (c) 2021, WooSignal Ltd.
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

import 'dart:convert';

import 'package:woosignal/models/links.dart';

List<Reports> reportsFromJson(String str) =>
    List<Reports>.from(json.decode(str).map((x) => Reports.fromJson(x)));

String reportsToJson(List<Reports> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Reports {
  Reports({
    this.slug,
    this.description,
    this.links,
  });

  String slug;
  String description;
  Links links;

  factory Reports.fromJson(Map<String, dynamic> json) => Reports(
        slug: json["slug"],
        description: json["description"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "description": description,
        "_links": links.toJson(),
      };
}

// To parse this JSON data, do
//
//     final salesReports = salesReportsFromJson(jsonString);

// To parse this JSON data, do
//
//     final salesReports = salesReportsFromJson(jsonString);

// SalesReports salesReportsFromJson(String str) =>
//     SalesReports.fromJson(json.decode(str));

// String salesReportsToJson(SalesReports data) => json.encode(data.toJson());

// class SalesReports {
//   SalesReports({
//     this.totalSales,
//     this.netSales,
//     this.averageSales,
//     this.totalOrders,
//     this.totalItems,
//     this.totalTax,
//     this.totalShipping,
//     this.totalRefunds,
//     this.totalDiscount,
//     this.totalsGroupedBy,
//     this.totals,
//     this.totalCustomers,
//     this.links,
//   });

//   String totalSales;
//   String netSales;
//   String averageSales;
//   int totalOrders;
//   int totalItems;
//   String totalTax;
//   String totalShipping;
//   int totalRefunds;
//   String totalDiscount;
//   String totalsGroupedBy;
//   Map<String, Total> totals;
//   int totalCustomers;
//   Links links;

//   factory SalesReports.fromJson(Map<String, dynamic> json) => SalesReports(
//         totalSales: json["total_sales"],
//         netSales: json["net_sales"],
//         averageSales: json["average_sales"],
//         totalOrders: json["total_orders"],
//         totalItems: json["total_items"],
//         totalTax: json["total_tax"],
//         totalShipping: json["total_shipping"],
//         totalRefunds: json["total_refunds"],
//         totalDiscount: json["total_discount"],
//         totalsGroupedBy: json["totals_grouped_by"],
//         totals: Map.from(json["totals"])
//             .map((k, v) => MapEntry<String, Total>(k, Total.fromJson(v))),
//         totalCustomers: json["total_customers"],
//         links: Links.fromJson(json["_links"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "total_sales": totalSales,
//         "net_sales": netSales,
//         "average_sales": averageSales,
//         "total_orders": totalOrders,
//         "total_items": totalItems,
//         "total_tax": totalTax,
//         "total_shipping": totalShipping,
//         "total_refunds": totalRefunds,
//         "total_discount": totalDiscount,
//         "totals_grouped_by": totalsGroupedBy,
//         "totals": Map.from(totals)
//             .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
//         "total_customers": totalCustomers,
//         "_links": links.toJson(),
//       };
// }

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

  String sales;
  int orders;
  int items;
  String tax;
  String shipping;
  String discount;
  int customers;

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

TotalReport totalReportFromJson(String str) =>
    TotalReport.fromJson(json.decode(str));

String totalReportToJson(TotalReport data) => json.encode(data.toJson());

class TotalReport {
  TotalReport({
    this.slug,
    this.name,
    this.total,
  });

  String slug;
  String name;
  int total;

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
