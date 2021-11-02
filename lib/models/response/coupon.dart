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

import 'package:woosignal/models/links.dart';
import 'package:woosignal/models/payload/order_wc.dart';

class Coupon {
  int? id;
  String? code;
  String? amount;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? discountType;
  String? description;
  String? dateExpires;
  String? dateExpiresGmt;
  int? usageCount;
  bool? individualUse;
  List<dynamic>? productIds;
  List<dynamic>? excludedProductIds;
  int? usageLimit;
  int? usageLimitPerUser;
  int? limitUsageToXItems;
  bool? freeShipping;
  List<dynamic>? productCategories;
  List<dynamic>? excludedProductCategories;
  bool? excludeSaleItems;
  String? minimumAmount;
  String? maximumAmount;
  List<dynamic>? emailRestrictions;
  List<dynamic>? usedBy;
  List<MetaData>? metaData;
  Links? links;

  Coupon(
      {this.id,
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
      this.links});

  Coupon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    amount = json['amount'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    discountType = json['discount_type'];
    description = json['description'];
    dateExpires = json['date_expires'];
    dateExpiresGmt = json['date_expires_gmt'];
    usageCount = json['usage_count'];
    individualUse = json['individual_use'];
    productIds = (json['product_ids'] != null) ? json['product_ids'] : null;
    excludedProductIds = (json['excluded_product_ids'] != null)
        ? json['excluded_product_ids']
        : null;
    usageLimit = json['usage_limit'];
    usageLimitPerUser = json['usage_limit_per_user'];
    limitUsageToXItems = json['limit_usage_to_x_items'];
    freeShipping = json['free_shipping'];
    productCategories = (json['product_categories'] != null)
        ? json['product_categories']
        : null;
    productCategories = (json['product_categories'] != null)
        ? json['product_categories']
        : null;
    excludeSaleItems = json['exclude_sale_items'];
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
    emailRestrictions = (json['email_restrictions'] != null)
        ? json['email_restrictions']
        : null;
    usedBy = (json['used_by'] != null) ? json['used_by'] : null;
    if (json['meta_data'] != null) {
      metaData = [];
      json['meta_data'].forEach((v) {
        metaData!.add(new MetaData.fromJson(v));
      });
    }
    links = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['amount'] = this.amount;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['date_modified'] = this.dateModified;
    data['date_modified_gmt'] = this.dateModifiedGmt;
    data['discount_type'] = this.discountType;
    data['description'] = this.description;
    data['date_expires'] = this.dateExpires;
    data['date_expires_gmt'] = this.dateExpiresGmt;
    data['usage_count'] = this.usageCount;
    data['individual_use'] = this.individualUse;
    data['product_ids'] = this.productIds;
    data['excluded_product_ids'] = this.excludedProductIds;
    data['usage_limit'] = this.usageLimit;
    data['usage_limit_per_user'] = this.usageLimitPerUser;
    data['limit_usage_to_x_items'] = this.limitUsageToXItems;
    data['free_shipping'] = this.freeShipping;
    data['product_categories'] = this.productCategories;
    data['excluded_product_categories'] = this.excludedProductCategories;
    data['exclude_sale_items'] = this.excludeSaleItems;
    data['minimum_amount'] = this.minimumAmount;
    data['maximum_amount'] = this.maximumAmount;
    data['email_restrictions'] = this.emailRestrictions;
    data['used_by'] = this.usedBy;
    if (this.metaData != null) {
      data['meta_data'] = this.metaData!.map((v) => v.toJson()).toList();
    }
    if (this.links != null) {
      data['_links'] = this.links!.toJson();
    }
    return data;
  }
}
