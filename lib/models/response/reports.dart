// To parse this JSON data, do
//
//     final reports = reportsFromJson(jsonString);

import 'dart:convert';

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
// To parse this JSON data, do
//
//     final salesReports = salesReportsFromJson(jsonString);

// To parse this JSON data, do
//
//     final salesReports = salesReportsFromJson(jsonString);

SalesReports salesReportsFromJson(String str) =>
    SalesReports.fromJson(json.decode(str));

String salesReportsToJson(SalesReports data) => json.encode(data.toJson());

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
  Map<String, Total> totals;
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
        totals: Map.from(json["totals"])
            .map((k, v) => MapEntry<String, Total>(k, Total.fromJson(v))),
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
        "totals": Map.from(totals)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "total_customers": totalCustomers,
        "_links": links.toJson(),
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
// To parse this JSON data, do
//
//     final topSellerReport = topSellerReportFromJson(jsonString);

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

class Links2 {
  Links2({
    this.about,
    this.product,
  });

  List<About> about;
  List<About> product;

  factory Links2.fromJson(Map<String, dynamic> json) => Links2(
        about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
        product:
            List<About>.from(json["product"].map((x) => About.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "about": List<dynamic>.from(about.map((x) => x.toJson())),
        "product": List<dynamic>.from(product.map((x) => x.toJson())),
      };
}

class About2 {
  About2({
    this.href,
  });

  String href;

  factory About2.fromJson(Map<String, dynamic> json) => About2(
        href: json["href"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
      };
}
// To parse this JSON data, do
//
//     final couponReport = couponReportFromJson(jsonString);

// To parse this JSON data, do
//
//     final totalReport = totalReportFromJson(jsonString);

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
