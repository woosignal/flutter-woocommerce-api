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

import 'package:woosignal/models/image.dart';
import 'package:woosignal/models/links.dart';

class ProductBatch {
  ProductBatch({
    this.create,
    this.update,
    this.delete,
  });

  List<Create>? create;
  List<Create>? update;
  List<Create>? delete;

  factory ProductBatch.fromJson(Map<String, dynamic> json) => ProductBatch(
        create:
            List<Create>.from(json["create"].map((x) => Create.fromJson(x))),
        update:
            List<Create>.from(json["update"].map((x) => Create.fromJson(x))),
        delete:
            List<Create>.from(json["delete"].map((x) => Create.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "create": List<dynamic>.from(create!.map((x) => x.toJson())),
        "update": List<dynamic>.from(update!.map((x) => x.toJson())),
        "delete": List<dynamic>.from(delete!.map((x) => x.toJson())),
      };
}

class Create {
  Create({
    this.id,
    this.name,
    this.slug,
    this.permalink,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.type,
    this.status,
    this.featured,
    this.catalogVisibility,
    this.description,
    this.shortDescription,
    this.sku,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.dateOnSaleFrom,
    this.dateOnSaleFromGmt,
    this.dateOnSaleTo,
    this.dateOnSaleToGmt,
    this.priceHtml,
    this.onSale,
    this.purchasable,
    this.totalSales,
    this.virtual,
    this.downloadable,
    this.downloads,
    this.downloadLimit,
    this.downloadExpiry,
    this.externalUrl,
    this.buttonText,
    this.taxStatus,
    this.taxClass,
    this.manageStock,
    this.stockQuantity,
    this.stockStatus,
    this.backorders,
    this.backordersAllowed,
    this.backordered,
    this.soldIndividually,
    this.weight,
    this.dimensions,
    this.shippingRequired,
    this.shippingTaxable,
    this.shippingClass,
    this.shippingClassId,
    this.reviewsAllowed,
    this.averageRating,
    this.ratingCount,
    this.relatedIds,
    this.upsellIds,
    this.crossSellIds,
    this.parentId,
    this.purchaseNote,
    this.categories,
    this.tags,
    this.images,
    this.attributes,
    this.defaultAttributes,
    this.variations,
    this.groupedProducts,
    this.menuOrder,
    this.metaData,
    this.links,
  });

  int? id;
  String? name;
  String? slug;
  String? permalink;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? type;
  String? status;
  bool? featured;
  String? catalogVisibility;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  dynamic dateOnSaleFrom;
  dynamic dateOnSaleFromGmt;
  dynamic dateOnSaleTo;
  dynamic dateOnSaleToGmt;
  String? priceHtml;
  bool? onSale;
  bool? purchasable;
  int? totalSales;
  bool? virtual;
  bool? downloadable;
  List<Download>? downloads;
  int? downloadLimit;
  int? downloadExpiry;
  String? externalUrl;
  String? buttonText;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  dynamic stockQuantity;
  String? stockStatus;
  String? backorders;
  bool? backordersAllowed;
  bool? backordered;
  bool? soldIndividually;
  String? weight;
  Dimensions? dimensions;
  bool? shippingRequired;
  bool? shippingTaxable;
  String? shippingClass;
  int? shippingClassId;
  bool? reviewsAllowed;
  String? averageRating;
  int? ratingCount;
  List<int>? relatedIds;
  List<dynamic>? upsellIds;
  List<dynamic>? crossSellIds;
  int? parentId;
  String? purchaseNote;
  List<Category>? categories;
  List<dynamic>? tags;
  List<Image>? images;
  List<Attribute>? attributes;
  List<DefaultAttribute>? defaultAttributes;
  List<dynamic>? variations;
  List<dynamic>? groupedProducts;
  int? menuOrder;
  List<dynamic>? metaData;
  Links? links;

  factory Create.fromJson(Map<String, dynamic> json) => Create(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        permalink: json["permalink"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        type: json["type"],
        status: json["status"],
        featured: json["featured"],
        catalogVisibility: json["catalog_visibility"],
        description: json["description"],
        shortDescription: json["short_description"],
        sku: json["sku"],
        price: json["price"],
        regularPrice: json["regular_price"],
        salePrice: json["sale_price"],
        dateOnSaleFrom: json["date_on_sale_from"],
        dateOnSaleFromGmt: json["date_on_sale_from_gmt"],
        dateOnSaleTo: json["date_on_sale_to"],
        dateOnSaleToGmt: json["date_on_sale_to_gmt"],
        priceHtml: json["price_html"],
        onSale: json["on_sale"],
        purchasable: json["purchasable"],
        totalSales: json["total_sales"],
        virtual: json["virtual"],
        downloadable: json["downloadable"],
        downloads: List<Download>.from(
            json["downloads"].map((x) => Download.fromJson(x))),
        downloadLimit: json["download_limit"],
        downloadExpiry: json["download_expiry"],
        externalUrl: json["external_url"],
        buttonText: json["button_text"],
        taxStatus: json["tax_status"],
        taxClass: json["tax_class"],
        manageStock: json["manage_stock"],
        stockQuantity: json["stock_quantity"],
        stockStatus: json["stock_status"],
        backorders: json["backorders"],
        backordersAllowed: json["backorders_allowed"],
        backordered: json["backordered"],
        soldIndividually: json["sold_individually"],
        weight: json["weight"],
        dimensions: Dimensions.fromJson(json["dimensions"]),
        shippingRequired: json["shipping_required"],
        shippingTaxable: json["shipping_taxable"],
        shippingClass: json["shipping_class"],
        shippingClassId: json["shipping_class_id"],
        reviewsAllowed: json["reviews_allowed"],
        averageRating: json["average_rating"],
        ratingCount: json["rating_count"],
        relatedIds: List<int>.from(json["related_ids"].map((x) => x)),
        upsellIds: List<dynamic>.from(json["upsell_ids"].map((x) => x)),
        crossSellIds: List<dynamic>.from(json["cross_sell_ids"].map((x) => x)),
        parentId: json["parent_id"],
        purchaseNote: json["purchase_note"],
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
        tags: List<dynamic>.from(json["tags"].map((x) => x)),
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        attributes: List<Attribute>.from(
            json["attributes"].map((x) => Attribute.fromJson(x))),
        defaultAttributes: List<DefaultAttribute>.from(
            json["default_attributes"]
                .map((x) => DefaultAttribute.fromJson(x))),
        variations: List<dynamic>.from(json["variations"].map((x) => x)),
        groupedProducts:
            List<dynamic>.from(json["grouped_products"].map((x) => x)),
        menuOrder: json["menu_order"],
        metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "permalink": permalink,
        "date_created": dateCreated!.toIso8601String(),
        "date_created_gmt": dateCreatedGmt!.toIso8601String(),
        "date_modified": dateModified!.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt!.toIso8601String(),
        "type": type,
        "status": status,
        "featured": featured,
        "catalog_visibility": catalogVisibility,
        "description": description,
        "short_description": shortDescription,
        "sku": sku,
        "price": price,
        "regular_price": regularPrice,
        "sale_price": salePrice,
        "date_on_sale_from": dateOnSaleFrom,
        "date_on_sale_from_gmt": dateOnSaleFromGmt,
        "date_on_sale_to": dateOnSaleTo,
        "date_on_sale_to_gmt": dateOnSaleToGmt,
        "price_html": priceHtml,
        "on_sale": onSale,
        "purchasable": purchasable,
        "total_sales": totalSales,
        "virtual": virtual,
        "downloadable": downloadable,
        "downloads": List<dynamic>.from(downloads!.map((x) => x.toJson())),
        "download_limit": downloadLimit,
        "download_expiry": downloadExpiry,
        "external_url": externalUrl,
        "button_text": buttonText,
        "tax_status": taxStatus,
        "tax_class": taxClass,
        "manage_stock": manageStock,
        "stock_quantity": stockQuantity,
        "stock_status": stockStatus,
        "backorders": backorders,
        "backorders_allowed": backordersAllowed,
        "backordered": backordered,
        "sold_individually": soldIndividually,
        "weight": weight,
        "dimensions": dimensions!.toJson(),
        "shipping_required": shippingRequired,
        "shipping_taxable": shippingTaxable,
        "shipping_class": shippingClass,
        "shipping_class_id": shippingClassId,
        "reviews_allowed": reviewsAllowed,
        "average_rating": averageRating,
        "rating_count": ratingCount,
        "related_ids": List<dynamic>.from(relatedIds!.map((x) => x)),
        "upsell_ids": List<dynamic>.from(upsellIds!.map((x) => x)),
        "cross_sell_ids": List<dynamic>.from(crossSellIds!.map((x) => x)),
        "parent_id": parentId,
        "purchase_note": purchaseNote,
        "categories": List<dynamic>.from(categories!.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags!.map((x) => x)),
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "attributes": List<dynamic>.from(attributes!.map((x) => x.toJson())),
        "default_attributes":
            List<dynamic>.from(defaultAttributes!.map((x) => x.toJson())),
        "variations": List<dynamic>.from(variations!.map((x) => x)),
        "grouped_products": List<dynamic>.from(groupedProducts!.map((x) => x)),
        "menu_order": menuOrder,
        "meta_data": List<dynamic>.from(metaData!.map((x) => x)),
        "_links": links!.toJson(),
      };
}

class Attribute {
  Attribute({
    this.id,
    this.name,
    this.position,
    this.visible,
    this.variation,
    this.options,
  });

  int? id;
  String? name;
  int? position;
  bool? visible;
  bool? variation;
  List<String>? options;

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        name: json["name"],
        position: json["position"],
        visible: json["visible"],
        variation: json["variation"],
        options: List<String>.from(json["options"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "position": position,
        "visible": visible,
        "variation": variation,
        "options": List<dynamic>.from(options!.map((x) => x)),
      };
}

class Category {
  Category({
    this.id,
    this.name,
    this.slug,
  });

  int? id;
  String? name;
  String? slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
      };
}

class DefaultAttribute {
  DefaultAttribute({
    this.id,
    this.name,
    this.option,
  });

  int? id;
  String? name;
  String? option;

  factory DefaultAttribute.fromJson(Map<String, dynamic> json) =>
      DefaultAttribute(
        id: json["id"],
        name: json["name"],
        option: json["option"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "option": option,
      };
}

class Dimensions {
  Dimensions({
    this.length,
    this.width,
    this.height,
  });

  String? length;
  String? width;
  String? height;

  factory Dimensions.fromJson(Map<String, dynamic> json) => Dimensions(
        length: json["length"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "length": length,
        "width": width,
        "height": height,
      };
}

class Download {
  Download({
    this.id,
    this.name,
    this.file,
  });

  int? id;
  String? name;
  String? file;

  factory Download.fromJson(Map<String, dynamic> json) => Download(
        id: json["id"],
        name: json["name"],
        file: json["file"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "file": file,
      };
}
