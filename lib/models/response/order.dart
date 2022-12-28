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

import '../meta_data.dart';

class Order {
  int? id;
  int? parentId;
  String? number;
  String? orderKey;
  String? createdVia;
  String? version;
  String? status;
  String? currency;
  String? dateCreated;
  String? dateCreatedGmt;
  String? dateModified;
  String? dateModifiedGmt;
  String? discountTotal;
  String? discountTax;
  String? shippingTotal;
  String? shippingTax;
  String? cartTax;
  String? total;
  String? totalTax;
  bool? pricesIncludeTax;
  int? customerId;
  String? customerIpAddress;
  String? customerUserAgent;
  String? customerNote;
  Billing? billing;
  Shipping? shipping;
  String? paymentMethod;
  String? paymentMethodTitle;
  String? transactionId;
  String? datePaid;
  String? datePaidGmt;
  String? dateCompleted;
  String? dateCompletedGmt;
  String? cartHash;
  List<MetaData>? metaData;
  List<LineItems>? lineItems;
  List<TaxLines>? taxLines;
  List<ShippingLines>? shippingLines;
  List<FeeLine>? feeLines;
  List<CouponLine>? couponLines;
  List<Refunds>? refunds;
  Links? links;

  Order(
      {this.id,
      this.parentId,
      this.number,
      this.orderKey,
      this.createdVia,
      this.version,
      this.status,
      this.currency,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.discountTotal,
      this.discountTax,
      this.shippingTotal,
      this.shippingTax,
      this.cartTax,
      this.total,
      this.totalTax,
      this.pricesIncludeTax,
      this.customerId,
      this.customerIpAddress,
      this.customerUserAgent,
      this.customerNote,
      this.billing,
      this.shipping,
      this.paymentMethod,
      this.paymentMethodTitle,
      this.transactionId,
      this.datePaid,
      this.datePaidGmt,
      this.dateCompleted,
      this.dateCompletedGmt,
      this.cartHash,
      this.metaData,
      this.lineItems,
      this.taxLines,
      this.shippingLines,
      this.feeLines,
      this.couponLines,
      this.refunds,
      this.links});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    number = json['number'];
    orderKey = json['order_key'];
    createdVia = json['created_via'];
    version = json['version'];
    status = json['status'];
    currency = json['currency'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    dateModified = json['date_modified'];
    dateModifiedGmt = json['date_modified_gmt'];
    discountTotal = json['discount_total'];
    discountTax = json['discount_tax'];
    shippingTotal = json['shipping_total'];
    shippingTax = json['shipping_tax'];
    cartTax = json['cart_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    pricesIncludeTax = json['prices_include_tax'];
    customerId = json['customer_id'];
    customerIpAddress = json['customer_ip_address'];
    customerUserAgent = json['customer_user_agent'];
    customerNote = json['customer_note'];
    billing =
        json['billing'] != null ? Billing.fromJson(json['billing']) : null;
    shipping =
        json['shipping'] != null ? Shipping.fromJson(json['shipping']) : null;
    paymentMethod = json['payment_method'];
    paymentMethodTitle = json['payment_method_title'];
    transactionId = json['transaction_id'];
    datePaid = json['date_paid'];
    datePaidGmt = json['date_paid_gmt'];
    dateCompleted = json['date_completed'];
    dateCompletedGmt = json['date_completed_gmt'];
    cartHash = json['cart_hash'];
    if (json['meta_data'] != null) {
      metaData =
          (json['meta_data'] as List).map((i) => MetaData.fromJson(i)).toList();
    }
    if (json['line_items'] != null) {
      lineItems = [];
      json['line_items'].forEach((v) {
        lineItems!.add(LineItems.fromJson(v));
      });
    }
    if (json['tax_lines'] != null) {
      taxLines = [];
      json['tax_lines'].forEach((v) {
        taxLines!.add(TaxLines.fromJson(v));
      });
    }
    if (json['shipping_lines'] != null) {
      shippingLines = [];
      json['shipping_lines'].forEach((v) {
        shippingLines!.add(ShippingLines.fromJson(v));
      });
    }
    if (json['fee_lines'] != null) {
      feeLines = [];
      json['fee_lines'].forEach((v) {
        feeLines!.add(FeeLine.fromJson(v));
      });
    }
    if (json['coupon_lines'] != null) {
      couponLines = [];
      json['coupon_lines'].forEach((v) {
        couponLines!.add(CouponLine.fromJson(v));
      });
    }

    if (json['refunds'] != null) {
      refunds = [];
      json['refunds'].forEach((v) {
        refunds!.add(Refunds.fromJson(v));
      });
    }
    links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['number'] = number;
    data['order_key'] = orderKey;
    data['created_via'] = createdVia;
    data['version'] = version;
    data['status'] = status;
    data['currency'] = currency;
    data['date_created'] = dateCreated;
    data['date_created_gmt'] = dateCreatedGmt;
    data['date_modified'] = dateModified;
    data['date_modified_gmt'] = dateModifiedGmt;
    data['discount_total'] = discountTotal;
    data['discount_tax'] = discountTax;
    data['shipping_total'] = shippingTotal;
    data['shipping_tax'] = shippingTax;
    data['cart_tax'] = cartTax;
    data['total'] = total;
    data['total_tax'] = totalTax;
    data['prices_include_tax'] = pricesIncludeTax;
    data['customer_id'] = customerId;
    data['customer_ip_address'] = customerIpAddress;
    data['customer_user_agent'] = customerUserAgent;
    data['customer_note'] = customerNote;
    if (billing != null) {
      data['billing'] = billing!.toJson();
    }
    if (shipping != null) {
      data['shipping'] = shipping!.toJson();
    }
    data['payment_method'] = paymentMethod;
    data['payment_method_title'] = paymentMethodTitle;
    data['transaction_id'] = transactionId;
    data['date_paid'] = datePaid;
    data['date_paid_gmt'] = datePaidGmt;
    data['date_completed'] = dateCompleted;
    data['date_completed_gmt'] = dateCompletedGmt;
    data['cart_hash'] = cartHash;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    if (lineItems != null) {
      data['line_items'] = lineItems!.map((v) => v.toJson()).toList();
    }
    if (taxLines != null) {
      data['tax_lines'] = taxLines!.map((v) => v.toJson()).toList();
    }
    if (shippingLines != null) {
      data['shipping_lines'] = shippingLines!.map((v) => v.toJson()).toList();
    }
    if (feeLines != null) {
      data['fee_lines'] = feeLines!.map((v) => v.toJson()).toList();
    }
    if (couponLines != null) {
      data['coupon_lines'] = couponLines!.map((v) => v.toJson()).toList();
    }

    if (refunds != null) {
      data['refunds'] = refunds!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['_links'] = links!.toJson();
    }
    return data;
  }
}

class CouponLine {
  int? id;
  String? code;
  String? discount;
  String? discountTax;
  List<MetaData> metaData;

  CouponLine(
      this.id, this.code, this.discount, this.discountTax, this.metaData);

  CouponLine.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        code = json['code'],
        discount = json['discount'],
        discountTax = json['discount_tax'],
        metaData = (json['meta_data'] as List)
            .map((i) => MetaData.fromJson(i))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['discount'] = discount;
    data['discount_tax'] = discountTax;
    data['meta_data'] = metaData.map((v) => v.toJson()).toList();
    return data;
  }
}

class FeeLine {
  int? id;
  String? name;
  String? taxClass;
  String? taxStatus;
  String? total;
  String? totalTax;
  List<FeeLineTax> taxes;
  List<MetaData> metaData;

  FeeLine(this.id, this.name, this.taxClass, this.taxStatus, this.totalTax,
      this.taxes, this.metaData);

  FeeLine.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        taxClass = json['tax_class'],
        taxStatus = json['tax_status'],
        total = json['total'],
        totalTax = json['total_tax'],
        taxes =
            (json['taxes'] as List).map((i) => FeeLineTax.fromJson(i)).toList(),
        metaData = (json['meta_data'] as List)
            .map((i) => MetaData.fromJson(i))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['tax_class'] = taxClass;
    data['tax_status'] = taxStatus;
    data['total'] = total;
    data['total_tax'] = totalTax;
    data['taxes'] = taxes;
    data['meta_data'] = metaData.map((v) => v.toJson()).toList();
    return data;
  }
}

class FeeLineTax {
  int? id;
  String? rateCode;
  String? rateId;
  String? label;
  bool? compound;
  String? taxTotal;
  String? shippingTaxTotal;
  List<MetaData>? metaData;

  FeeLineTax(this.id, this.rateCode, this.rateId, this.label, this.compound,
      this.taxTotal, this.shippingTaxTotal, this.metaData);

  FeeLineTax.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rateCode = json['rate_code'];
    rateId = json['rate_id'];
    label = json['label'];
    compound = json['compound'];
    taxTotal = json['tax_total'];
    shippingTaxTotal = json['shipping_tax_total'];
    if (json['meta_data'] != null) {
      metaData =
          (json['meta_data'] as List).map((i) => MetaData.fromJson(i)).toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rate_id'] = rateId;
    data['rate_code'] = rateCode;
    data['label'] = label;
    data['compound'] = compound;
    data['tax_total'] = taxTotal;
    data['shipping_tax_total'] = shippingTaxTotal;
    data['meta_data'] = metaData;
    return data;
  }
}

class Billing {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;
  String? email;
  String? phone;

  Billing(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country,
      this.email,
      this.phone});

  Billing.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company'] = company;
    data['address_1'] = address1;
    data['address_2'] = address2;
    data['city'] = city;
    data['state'] = state;
    data['postcode'] = postcode;
    data['country'] = country;
    data['email'] = email;
    data['phone'] = phone;
    return data;
  }
}

class Shipping {
  String? firstName;
  String? lastName;
  String? company;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? postcode;
  String? country;

  Shipping(
      {this.firstName,
      this.lastName,
      this.company,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.postcode,
      this.country});

  Shipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    company = json['company'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    city = json['city'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['company'] = company;
    data['address_1'] = address1;
    data['address_2'] = address2;
    data['city'] = city;
    data['state'] = state;
    data['postcode'] = postcode;
    data['country'] = country;
    return data;
  }
}

class Refunds {
  int? id;
  String? reason;
  String? total;

  Refunds({this.id, this.reason, this.total});

  Refunds.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reason'] = reason;
    data['total'] = total;
    return data;
  }
}

class LineItems {
  int? id;
  String? name;
  int? productId;
  int? variationId;
  int? quantity;
  String? taxClass;
  String? subtotal;
  String? subtotalTax;
  String? total;
  String? totalTax;
  List<Taxes>? taxes;
  List<MetaData>? metaData;
  String? sku;
  String? price;

  LineItems(
      {this.id,
      this.name,
      this.productId,
      this.variationId,
      this.quantity,
      this.taxClass,
      this.subtotal,
      this.subtotalTax,
      this.total,
      this.totalTax,
      this.taxes,
      this.metaData,
      this.sku,
      this.price});

  LineItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    productId = json['product_id'];
    variationId = json['variation_id'];
    quantity = json['quantity'];
    taxClass = json['tax_class'];
    subtotal = json['subtotal'];
    subtotalTax = json['subtotal_tax'];
    total = json['total'];
    totalTax = json['total_tax'];
    taxes = (json['taxes'] as List).map((i) => Taxes.fromJson(i)).toList();
    metaData =
        (json['meta_data'] as List).map((i) => MetaData.fromJson(i)).toList();
    sku = json['sku'];
    price = json['price'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['product_id'] = productId;
    data['variation_id'] = variationId;
    data['quantity'] = quantity;
    data['tax_class'] = taxClass;
    data['subtotal'] = subtotal;
    data['subtotal_tax'] = subtotalTax;
    data['total'] = total;
    data['total_tax'] = totalTax;
    if (taxes != null) {
      data['taxes'] = taxes!.map((v) => v.toJson()).toList();
    }
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    data['sku'] = sku;
    data['price'] = price;
    return data;
  }
}

class Taxes {
  int? id;
  String? total;
  String? subtotal;

  Taxes({this.id, this.total, this.subtotal});

  Taxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    total = json['total'];
    subtotal = json['subtotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['total'] = total;
    data['subtotal'] = subtotal;
    return data;
  }
}

class TaxLines {
  int? id;
  String? rateCode;
  int? rateId;
  String? label;
  bool? compound;
  String? taxTotal;
  String? shippingTaxTotal;
  List<MetaData>? metaData;

  TaxLines(
      {this.id,
      this.rateCode,
      this.rateId,
      this.label,
      this.compound,
      this.taxTotal,
      this.shippingTaxTotal,
      this.metaData});

  TaxLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rateCode = json['rate_code'];
    rateId = json['rate_id'];
    label = json['label'];
    compound = json['compound'];
    taxTotal = json['tax_total'];
    shippingTaxTotal = json['shipping_tax_total'];
    metaData =
        (json['meta_data'] as List).map((i) => MetaData.fromJson(i)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rate_code'] = rateCode;
    data['rate_id'] = rateId;
    data['label'] = label;
    data['compound'] = compound;
    data['tax_total'] = taxTotal;
    data['shipping_tax_total'] = shippingTaxTotal;
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingLines {
  int? id;
  String? methodTitle;
  String? methodId;
  String? total;
  String? totalTax;
  List<Taxes>? taxes;
  List<MetaData>? metaData;

  ShippingLines(
      {this.id,
      this.methodTitle,
      this.methodId,
      this.total,
      this.totalTax,
      this.taxes,
      this.metaData});

  ShippingLines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    methodTitle = json['method_title'];
    methodId = json['method_id'];
    total = json['total'];
    totalTax = json['total_tax'];

    taxes = (json['taxes'] as List).map((i) => Taxes.fromJson(i)).toList();
    metaData =
        (json['meta_data'] as List).map((i) => MetaData.fromJson(i)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['method_title'] = methodTitle;
    data['method_id'] = methodId;
    data['total'] = total;
    data['total_tax'] = totalTax;
    if (taxes != null) {
      data['taxes'] = taxes!.map((v) => v.toJson()).toList();
    }
    if (metaData != null) {
      data['meta_data'] = metaData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
