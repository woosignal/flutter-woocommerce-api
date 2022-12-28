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
  List<int>? productIds;
  List<int>? excludedProductIds;
  int? usageLimit;
  int? usageLimitPerUser;
  int? limitUsageToXItems;
  bool? freeShipping;
  List<int>? productCategories;
  List<int>? excludedProductCategories;
  bool? excludeSaleItems;
  String? minimumAmount;
  String? maximumAmount;
  List<String>? emailRestrictions;
  List<String>? usedBy;
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
    productIds =
        (json['product_ids'] != null) ? json['product_ids'].cast<int>() : null;
    excludedProductIds = (json['excluded_product_ids'] != null)
        ? json['excluded_product_ids'].cast<int>()
        : null;
    usageLimit = json['usage_limit'];
    usageLimitPerUser = json['usage_limit_per_user'];
    limitUsageToXItems = json['limit_usage_to_x_items'];
    freeShipping = json['free_shipping'];
    productCategories = (json['product_categories'] != null)
        ? json['product_categories'].cast<int>()
        : null;
    excludedProductCategories = (json['excluded_product_categories'] != null)
        ? json['excluded_product_categories'].cast<int>()
        : null;
    excludeSaleItems = json['exclude_sale_items'];
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
    emailRestrictions = (json['email_restrictions'] != null)
        ? json['email_restrictions'].cast<String>()
        : null;
    usedBy = (json['used_by'] != null) ? json['used_by'].cast<String>() : null;
    if (json['meta_data'] != null) {
      metaData = [];
      json['meta_data'].forEach((v) {
        metaData!.add(MetaData.fromJson(v));
      });
    }
    links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['amount'] = amount;
    data['date_created'] = dateCreated;
    data['date_created_gmt'] = dateCreatedGmt;
    data['date_modified'] = dateModified;
    data['date_modified_gmt'] = dateModifiedGmt;
    data['discount_type'] = discountType;
    data['description'] = description;
    data['date_expires'] = dateExpires;
    data['date_expires_gmt'] = dateExpiresGmt;
    data['usage_count'] = usageCount;
    data['individual_use'] = individualUse;
    data['product_ids'] = productIds;
    data['excluded_product_ids'] = excludedProductIds;
    data['usage_limit'] = usageLimit;
    data['usage_limit_per_user'] = usageLimitPerUser;
    data['limit_usage_to_x_items'] = limitUsageToXItems;
    data['free_shipping'] = freeShipping;
    data['product_categories'] = productCategories;
    data['excluded_product_categories'] = excludedProductCategories;
    data['exclude_sale_items'] = excludeSaleItems;
    data['minimum_amount'] = minimumAmount;
    data['maximum_amount'] = maximumAmount;
    data['email_restrictions'] = emailRestrictions;
    data['used_by'] = usedBy;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['_links'] = links!.toJson();
    }
    return data;
  }
}
