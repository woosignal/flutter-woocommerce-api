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

class SalesReports {
  SalesReports({
    this.totalSales,
    this.netSales,
    this.averageSales,
    this.totalOrders,
    this.totalItems,
    this.totalTax,
    this.totalShipping,
    this.totalRefunds,
    this.totalDiscount,
    this.totalsGroupedBy,
    this.totals,
    this.totalCustomers,
    this.links,
  });

  String? totalSales;
  String? netSales;
  String? averageSales;
  int? totalOrders;
  int? totalItems;
  String? totalTax;
  String? totalShipping;
  int? totalRefunds;
  String? totalDiscount;
  String? totalsGroupedBy;
  dynamic totals;
  int? totalCustomers;
  Links? links;

  factory SalesReports.fromJson(Map<String, dynamic> json) => SalesReports(
        totalSales: json["total_sales"],
        netSales: json["net_sales"],
        averageSales: json["average_sales"],
        totalOrders: json["total_orders"],
        totalItems: json["total_items"],
        totalTax: json["total_tax"],
        totalShipping: json["total_shipping"],
        totalRefunds: json["total_refunds"],
        totalDiscount: json["total_discount"],
        totalsGroupedBy: json["totals_grouped_by"],
        totals: json['totals'],
        totalCustomers: json["total_customers"],
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "total_sales": totalSales,
        "net_sales": netSales,
        "average_sales": averageSales,
        "total_orders": totalOrders,
        "total_items": totalItems,
        "total_tax": totalTax,
        "total_shipping": totalShipping,
        "total_refunds": totalRefunds,
        "total_discount": totalDiscount,
        "totals_grouped_by": totalsGroupedBy,
        "totals": totals.toJson(),
        "total_customers": totalCustomers,
        "_links": links!.toJson(),
      };
}

class Links {
  Links({
    this.about,
  });

  List<About>? about;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "about": List<dynamic>.from(about!.map((x) => x.toJson())),
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
