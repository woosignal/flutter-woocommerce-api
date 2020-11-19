import 'package:woosignal/models/response/customer.dart';
import 'package:woosignal/models/payload/order_wc.dart';

class Coupon {
  int id;
  String code;
  String amount;
  String dateCreated;
  String dateCreatedGmt;
  String dateModified;
  String dateModifiedGmt;
  String discountType;
  String description;
  String dateExpires;
  String dateExpiresGmt;
  int usageCount;
  bool individualUse;
  List<dynamic> productIds;
  List<dynamic> excludedProductIds;
  int usageLimit;
  int usageLimitPerUser;
  int limitUsageToXItems;
  bool freeShipping;
  List<dynamic> productCategories;
  List<dynamic> excludedProductCategories;
  bool excludeSaleItems;
  String minimumAmount;
  String maximumAmount;
  List<dynamic> emailRestrictions;
  List<dynamic> usedBy;
  List<MetaData> metaData;
  Links lLinks;

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
      this.lLinks});

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
    //Error Expected
    productIds = (json['product_ids'] != null) ? json['product_ids'] : null;
    //Error Expected
    // excludedProductIds = json['excluded_product_ids'];
    excludedProductIds = (json['excluded_product_ids'] != null)
        ? json['excluded_product_ids']
        : null;
    usageLimit = json['usage_limit'];
    usageLimitPerUser = json['usage_limit_per_user'];
    limitUsageToXItems = json['limit_usage_to_x_items'];
    freeShipping = json['free_shipping'];
    //Error Expected
    // productCategories = json['product_categories'];
    productCategories = (json['product_categories'] != null)
        ? json['product_categories']
        : null;
    //Error Expected
    // excludedProductCategories = json['excluded_product_categories'];
    productCategories = (json['product_categories'] != null)
        ? json['product_categories']
        : null;
    excludeSaleItems = json['exclude_sale_items'];
    minimumAmount = json['minimum_amount'];
    maximumAmount = json['maximum_amount'];
    //Error Expected

    // emailRestrictions = json['email_restrictions'].cast<String>();
    emailRestrictions = (json['email_restrictions'] != null)
        ? json['email_restrictions']
        : null;
    //Error Expected
    // usedBy = json['used_by'].cast<String>();
    usedBy = (json['used_by'] != null) ? json['used_by'] : null;
    if (json['meta_data'] != null) {
      metaData = new List<MetaData>();
      json['meta_data'].forEach((v) {
        metaData.add(new MetaData.fromJson(v));
      });
    }
    lLinks = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
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
      data['meta_data'] = this.metaData.map((v) => v.toJson()).toList();
    }
    if (this.lLinks != null) {
      data['_links'] = this.lLinks.toJson();
    }
    return data;
  }
}

// class MetaData {
//   int id;
//   String key;
//   String value;

//   MetaData({this.id, this.key, this.value});

//   MetaData.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     key = json['key'];
//     value = json['value'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['key'] = this.key;
//     data['value'] = this.value;
//     return data;
//   }
// }

// class Links {
//   List<Self> self;
//   List<Collection> collection;

//   Links({this.self, this.collection});

//   Links.fromJson(Map<String, dynamic> json) {
//     if (json['self'] != null) {
//       self = new List<Self>();
//       json['self'].forEach((v) {
//         self.add(new Self.fromJson(v));
//       });
//     }
//     if (json['collection'] != null) {
//       collection = new List<Collection>();
//       json['collection'].forEach((v) {
//         collection.add(new Collection.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.self != null) {
//       data['self'] = this.self.map((v) => v.toJson()).toList();
//     }
//     if (this.collection != null) {
//       data['collection'] = this.collection.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Self {
  String href;

  Self({this.href});

  Self.fromJson(Map<String, dynamic> json) {
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    return data;
  }
}
