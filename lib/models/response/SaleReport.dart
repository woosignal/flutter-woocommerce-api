import 'dart:convert';

List<SalesReports> salesReportsFromJson(String str) => List<SalesReports>.from(
    json.decode(str).map((x) => SalesReports.fromJson(x)));

String salesReportsToJson(List<SalesReports> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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

  String totalSales;
  String netSales;
  String averageSales;
  int totalOrders;
  int totalItems;
  String totalTax;
  String totalShipping;
  int totalRefunds;
  String totalDiscount;
  String totalsGroupedBy;
  Totals totals;
  int totalCustomers;
  Links links;

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
        totals: Totals.fromJson(json["totals"]),
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
        "_links": links.toJson(),
      };
}

class Links {
  Links({
    this.about,
  });

  List<About> about;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "about": List<dynamic>.from(about.map((x) => x.toJson())),
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

class Totals {
  Totals({
    this.the20201108,
  });

  The20201108 the20201108;

  factory Totals.fromJson(Map<String, dynamic> json) => Totals(
        the20201108: The20201108.fromJson(json["2020-11-08"]),
      );

  Map<String, dynamic> toJson() => {
        "2020-11-08": the20201108.toJson(),
      };
}

class The20201108 {
  The20201108({
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

  factory The20201108.fromJson(Map<String, dynamic> json) => The20201108(
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
