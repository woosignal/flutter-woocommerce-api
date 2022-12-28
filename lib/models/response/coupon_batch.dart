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

class CouponBatch {
  CouponBatch({
    this.create,
    this.update,
    this.delete,
  });

  List<Create>? create;
  List<Create>? update;
  List<Create>? delete;

  factory CouponBatch.fromJson(Map<String, dynamic> json) => CouponBatch(
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
    this.code,
    this.amount,
    this.dateCreated,
    this.dateCreatedGmt,
    this.dateModified,
    this.dateModifiedGmt,
    this.discountType,
    this.description,
    this.dateExpires,
    this.dateExpiresGmt,
    this.usageCount,
    this.individualUse,
    this.productIds,
    this.excludedProductIds,
    this.usageLimit,
    this.usageLimitPerUser,
    this.limitUsageToXItems,
    this.freeShipping,
    this.productCategories,
    this.excludedProductCategories,
    this.excludeSaleItems,
    this.minimumAmount,
    this.maximumAmount,
    this.emailRestrictions,
    this.usedBy,
    this.metaData,
    this.links,
  });

  int? id;
  String? code;
  String? amount;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? discountType;
  String? description;
  dynamic dateExpires;
  dynamic dateExpiresGmt;
  int? usageCount;
  bool? individualUse;
  List<dynamic>? productIds;
  List<dynamic>? excludedProductIds;
  dynamic usageLimit;
  dynamic usageLimitPerUser;
  dynamic limitUsageToXItems;
  bool? freeShipping;
  List<dynamic>? productCategories;
  List<dynamic>? excludedProductCategories;
  bool? excludeSaleItems;
  String? minimumAmount;
  String? maximumAmount;
  List<dynamic>? emailRestrictions;
  List<dynamic>? usedBy;
  List<dynamic>? metaData;
  Links? links;

  factory Create.fromJson(Map<String, dynamic> json) => Create(
        id: json["id"],
        code: json["code"],
        amount: json["amount"],
        dateCreated: DateTime.parse(json["date_created"]),
        dateCreatedGmt: DateTime.parse(json["date_created_gmt"]),
        dateModified: DateTime.parse(json["date_modified"]),
        dateModifiedGmt: DateTime.parse(json["date_modified_gmt"]),
        discountType: json["discount_type"],
        description: json["description"],
        dateExpires: json["date_expires"],
        dateExpiresGmt: json["date_expires_gmt"],
        usageCount: json["usage_count"],
        individualUse: json["individual_use"],
        productIds: List<dynamic>.from(json["product_ids"].map((x) => x)),
        excludedProductIds:
            List<dynamic>.from(json["excluded_product_ids"].map((x) => x)),
        usageLimit: json["usage_limit"],
        usageLimitPerUser: json["usage_limit_per_user"],
        limitUsageToXItems: json["limit_usage_to_x_items"],
        freeShipping: json["free_shipping"],
        productCategories:
            List<dynamic>.from(json["product_categories"].map((x) => x)),
        excludedProductCategories: List<dynamic>.from(
            json["excluded_product_categories"].map((x) => x)),
        excludeSaleItems: json["exclude_sale_items"],
        minimumAmount: json["minimum_amount"],
        maximumAmount: json["maximum_amount"],
        emailRestrictions:
            List<dynamic>.from(json["email_restrictions"].map((x) => x)),
        usedBy: List<dynamic>.from(json["used_by"].map((x) => x)),
        metaData: List<dynamic>.from(json["meta_data"].map((x) => x)),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "amount": amount,
        "date_created": dateCreated!.toIso8601String(),
        "date_created_gmt": dateCreatedGmt!.toIso8601String(),
        "date_modified": dateModified!.toIso8601String(),
        "date_modified_gmt": dateModifiedGmt!.toIso8601String(),
        "discount_type": discountType,
        "description": description,
        "date_expires": dateExpires,
        "date_expires_gmt": dateExpiresGmt,
        "usage_count": usageCount,
        "individual_use": individualUse,
        "product_ids": List<dynamic>.from(productIds!.map((x) => x)),
        "excluded_product_ids":
            List<dynamic>.from(excludedProductIds!.map((x) => x)),
        "usage_limit": usageLimit,
        "usage_limit_per_user": usageLimitPerUser,
        "limit_usage_to_x_items": limitUsageToXItems,
        "free_shipping": freeShipping,
        "product_categories":
            List<dynamic>.from(productCategories!.map((x) => x)),
        "excluded_product_categories":
            List<dynamic>.from(excludedProductCategories!.map((x) => x)),
        "exclude_sale_items": excludeSaleItems,
        "minimum_amount": minimumAmount,
        "maximum_amount": maximumAmount,
        "email_restrictions":
            List<dynamic>.from(emailRestrictions!.map((x) => x)),
        "used_by": List<dynamic>.from(usedBy!.map((x) => x)),
        "meta_data": List<dynamic>.from(metaData!.map((x) => x)),
        "_links": links!.toJson(),
      };
}
