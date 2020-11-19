library woosignal;

// Copyright (c) 2020, WooSignal Ltd.
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

import 'package:woosignal/models/response/api_data.dart';
import 'package:woosignal/models/response/continent.dart';
import 'package:woosignal/models/response/currencies.dart';
import 'package:flutter/cupertino.dart';
import 'package:woosignal/models/response/orderBatch.dart';
import 'package:woosignal/models/response/refund.dart';
import 'package:woosignal/models/response/order_notes.dart';
import 'package:woosignal/models/response/coupon.dart';
import 'package:woosignal/models/response/coupon_batch.dart';
import 'package:woosignal/models/response/customer_batch.dart';
import 'package:woosignal/models/response/reports.dart';
import 'package:woosignal/networking/api_provider.dart';
import 'package:woosignal/helpers/shared_pref.dart';
import 'package:woosignal/models/response/products.dart';
import 'package:woosignal/models/response/product_review.dart';
import 'package:woosignal/models/response/product_category.dart';
import 'package:woosignal/models/response/customer.dart';
import 'package:woosignal/models/response/order.dart';
import 'package:woosignal/models/response/product_variation.dart';
import 'package:woosignal/models/response/product_attributes.dart';
import 'package:woosignal/models/response/product_attribute_term.dart';
import 'package:woosignal/models/response/product_shipping_class.dart';
import 'package:woosignal/models/response/tax_rate.dart';
import 'package:woosignal/models/response/tax_classes.dart';
import 'package:woosignal/models/response/shipping_zone.dart';
import 'package:woosignal/models/response/shipping_method.dart';
import 'package:woosignal/models/payload/order_wc.dart';
import 'package:woosignal/models/response/countries.dart';
import 'package:woosignal/models/response/payment_gateway.dart';
import 'package:woosignal/models/response/SaleReport.dart';
import 'package:woosignal/models/response/top_seller_report.dart';
import 'package:woosignal/models/response/system_status.dart';
import 'package:woosignal/models/response/setting_option.dart';
import 'package:woosignal/models/response/setting_option_batch.dart';

class WooSignal {
  ApiProvider _apiProvider;
  bool _shouldDebug;

  static Future<WooSignal> getInstance({Map<String, dynamic> config}) async {
    WooSignal wooSignal = new WooSignal._internal();
    await wooSignal._setApp(config: config);
    await wooSignal._init();
    return wooSignal;
  }

  WooSignal._internal();

  Future _setApp({Map<String, dynamic> config}) async {
    await storeUserApiKey(config['appKey']);
    await _setAppKey(config['appKey']);
    _setDebug(config['debugMode']);
  }

  Future _init() async {
    _apiProvider = new ApiProvider();
    await _apiProvider.initializationDone;
  }

  _setAppKey(String appKey) async {
    appKey ??= null;
    if (appKey != null) {
      await storeUserApiKey(appKey);
    } else {
      _printLog("Provide a valid app key. Visit https://woosignal.com");
    }
  }

  void _setDebug(bool shouldDebug) {
    shouldDebug ??= false;
    this._shouldDebug = shouldDebug;
  }

  bool _shouldDebugMode() {
    return this._shouldDebug;
  }

  void _printLog(String message) {
    if (_shouldDebugMode() == true) {
      print("WOOSIGNAL LOG: " + message);
    }
  }

  Map<String, dynamic> _standardPayload(String type, json, String path) {
    return {"type": type, "payload": json, "path": path};
  }

  /// https://woosignal.com/docs/api/1.0/products
  Future<List<Product>> getProducts(
      {int page,
      int perPage,
      String search,
      String after,
      String before,
      String order,
      String orderBy,
      String slug,
      String status,
      String type,
      String sku,
      String category,
      String tag,
      String shippingClass,
      String attribute,
      String attributeTerm,
      String taxClass,
      String minPrice,
      String maxPrice,
      String stockStatus,
      List<int> exclude,
      List<int> parentExclude,
      List<int> include,
      List<int> parent,
      int offset,
      bool featured,
      bool onSale}) async {
    Map<String, dynamic> payload = {};
    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (after != null) payload["after"] = after;
    if (before != null) payload["before"] = before;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["order_by"] = orderBy;
    if (slug != null) payload["slug"] = slug;
    if (status != null) payload["status"] = status;
    if (type != null) payload["type"] = type;
    if (sku != null) payload["sku"] = sku;
    if (category != null) payload["category"] = category;
    if (tag != null) payload["tag"] = tag;
    if (shippingClass != null) payload["shipping_class"] = shippingClass;
    if (attribute != null) payload["attribute"] = attribute;
    if (attributeTerm != null) payload["attribute_term"] = attributeTerm;
    if (taxClass != null) payload["tax_class"] = taxClass;
    if (minPrice != null) payload["min_price"] = minPrice;
    if (maxPrice != null) payload["max_price"] = maxPrice;
    if (stockStatus != null) payload["stock_status"] = stockStatus;
    if (exclude != null) payload["exclude"] = exclude;
    if (parentExclude != null) payload["parent_exclude"] = parentExclude;
    if (include != null) payload["include"] = include;
    if (parent != null) payload["parent"] = parent;
    if (offset != null) payload["offset"] = offset;
    if (featured != null) payload["featured"] = featured;
    if (onSale != null) payload["on_sale"] = onSale;

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "products");

    List<Product> products = [];
    await _apiProvider.post("/request", payload).then((json) {
      products = (json as List).map((i) => Product.fromJson(i)).toList();
    });
    _printLog(products.toString());
    return products;
  }

  /// https://woosignal.com/docs/api/1.0/products#retrive-a-product-api-call
  Future<Product> retrieveProduct({int id}) async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "products/${id.toString()}");

    Product product;
    await _apiProvider.post("/request", payload).then((json) {
      product = Product.fromJson(json);
    });
    _printLog(product.toString());
    return product;
  }

  /// https://woosignal.com/docs/api/1.0/products-variations
  Future<List<ProductVariation>> getProductVariations(int productId,
      {int page,
      int perPage,
      String search,
      String after,
      String before,
      List<int> exclude,
      List<int> include,
      int offset,
      String order,
      String orderBy,
      List<int> parent,
      List<int> parentExclude,
      String slug,
      String status,
      String sku,
      String taxClass,
      bool onSale,
      String minPrice,
      String maxPrice,
      String stockStatus}) async {
    Map<String, dynamic> payload = {};
    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (after != null) payload["after"] = after;
    if (before != null) payload["before"] = before;
    if (exclude != null) payload["exclude"] = exclude;
    if (include != null) payload["include"] = include;
    if (offset != null) payload["offset"] = offset;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
    if (parent != null) payload["parent"] = parent;
    if (parentExclude != null) payload["parent_exclude"] = parentExclude;
    if (slug != null) payload["slug"] = slug;
    if (status != null) payload["status"] = status;
    if (sku != null) payload["sku"] = sku;
    if (taxClass != null) payload["tax_class"] = taxClass;
    if (onSale != null) payload["on_sale"] = onSale;
    if (minPrice != null) payload["min_price"] = minPrice;
    if (maxPrice != null) payload["max_price"] = maxPrice;
    if (stockStatus != null) payload["stock_status"] = stockStatus;

    _printLog(payload.toString());
    payload = _standardPayload(
        "get", payload, "products/" + productId.toString() + "/variations");

    List<ProductVariation> productVariations = [];
    await _apiProvider.post("/request", payload).then((json) {
      productVariations =
          (json as List).map((i) => ProductVariation.fromJson(i)).toList();
    });
    _printLog(productVariations.toString());
    return productVariations;
  }

  /// https://woosignal.com/docs/api/1.0/products-attributes
  Future<List<ProductAttribute>> getProductAttributes() async {
    Map<String, dynamic> payload = {};

    _printLog(payload.toString());
    payload = _standardPayload("get", payload, "products/attributes");

    List<ProductAttribute> productAttributes = [];
    await _apiProvider.post("/request", payload).then((json) {
      productAttributes =
          (json as List).map((i) => ProductAttribute.fromJson(i)).toList();
    });
    _printLog(productAttributes.toString());
    return productAttributes;
  }

  /// https://woosignal.com/docs/api/1.0/products-attribute-terms
  Future<List<ProductAttributeTerm>> getProductAttributeTerms(int attributeId,
      {int page,
      int perPage,
      String search,
      List<int> exclude,
      List<int> include,
      String order,
      String orderBy,
      bool hideEmpty,
      int parent,
      int product,
      String slug}) async {
    Map<String, dynamic> payload = {};
    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (exclude != null) payload["exclude"] = exclude;
    if (include != null) payload["include"] = include;
    if (int != null) payload["int"] = int;
    if (int != null) payload["int"] = int;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
    if (hideEmpty != null) payload["hide_empty"] = hideEmpty;
    if (parent != null) payload["parent"] = parent;
    if (product != null) payload["product"] = product;
    if (slug != null) payload["slug"] = slug;

    _printLog(payload.toString());
    payload = _standardPayload("get", payload,
        "products/attributes/" + attributeId.toString() + "/terms");

    List<ProductAttributeTerm> productAttributeTerms = [];
    await _apiProvider.post("/request", payload).then((json) {
      productAttributeTerms =
          (json as List).map((i) => ProductAttributeTerm.fromJson(i)).toList();
    });
    _printLog(productAttributeTerms.toString());
    return productAttributeTerms;
  }

  /// https://woosignal.com/docs/api/1.0/product-categories
  Future<List<ProductCategory>> getProductCategories(
      {int page,
      int perPage,
      String search,
      List<int> exclude,
      List<int> include,
      String order,
      String orderBy,
      bool hideEmpty,
      int parent,
      int product,
      String slug}) async {
    Map<String, dynamic> payload = {};
    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (exclude != null) payload["exclude"] = exclude;
    if (include != null) payload["include"] = include;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
    if (hideEmpty != null) payload["hide_empty"] = hideEmpty;
    if (parent != null) payload["parent"] = parent;
    if (product != null) payload["product"] = product;
    if (slug != null) payload["slug"] = slug;

    _printLog(payload.toString());
    payload = _standardPayload("get", payload, "products/categories");

    List<ProductCategory> productCategories = [];
    await _apiProvider.post("/request", payload).then((json) {
      _printLog(json.toString());
      productCategories =
          (json as List).map((i) => ProductCategory.fromJson(i)).toList();
    });
    _printLog(productCategories.toString());
    return productCategories;
  }

  /// https://woosignal.com/docs/api/1.0/product-shipping-classes
  Future<List<ProductShippingClass>> getProductShippingClasses(
      {int page,
      int perPage,
      String search,
      List<int> exclude,
      List<int> include,
      int offset,
      String order,
      String orderBy,
      bool hideEmpty,
      int product,
      String slug}) async {
    Map<String, dynamic> payload = {};
    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (exclude != null) payload["exclude"] = exclude;
    if (include != null) payload["include"] = include;
    if (offset != null) payload["offset"] = offset;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
    if (hideEmpty != null) payload["hide_empty"] = hideEmpty;
    if (product != null) payload["product"] = product;
    if (slug != null) payload["slug"] = slug;

    _printLog(payload.toString());
    payload = _standardPayload("get", payload, "products/shipping_classes");

    List<ProductShippingClass> productShippingClasses = [];
    await _apiProvider.post("/request", payload).then((json) {
      productShippingClasses =
          (json as List).map((i) => ProductShippingClass.fromJson(i)).toList();
    });
    _printLog(productShippingClasses.toString());
    return productShippingClasses;
  }

  /// https://woosignal.com/docs/api/1.0/product-reviews
  Future<List<ProductReview>> getProductReviews(
      {int page,
      int perPage,
      String search,
      String after,
      String before,
      List<int> exclude,
      List<int> include,
      int offset,
      String order,
      String orderBy,
      List<int> reviewer,
      List<int> reviewerExclude,
      List<String> reviewerEmail,
      List<int> product,
      String status}) async {
    Map<String, dynamic> payload = {};

    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (after != null) payload["after"] = after;
    if (before != null) payload["before"] = before;
    if (exclude != null) payload["exclude"] = exclude;
    if (include != null) payload["include"] = include;
    if (offset != null) payload["offset"] = offset;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
    if (reviewer != null) payload["reviewer"] = reviewer;
    if (reviewerExclude != null) payload["reviewer_exclude"] = reviewerExclude;
    if (reviewerEmail != null) payload["reviewer_email"] = reviewerEmail;
    if (product != null) payload["product"] = product;
    if (status != null) payload["status"] = status;

    _printLog(payload.toString());
    payload = _standardPayload("get", payload, "products/reviews");

    List<ProductReview> productReviews = [];
    await _apiProvider.post("/request", payload).then((json) {
      productReviews =
          (json as List).map((i) => ProductReview.fromJson(i)).toList();
    });
    _printLog(productReviews.toString());
    return productReviews;
  }

  /// https://woosignal.com/docs/api/1.0/product-reviews
  Future<ProductReview> createProductReview(
      {int productId,
      int status,
      String reviewer,
      String reviewerEmail,
      String review,
      int rating,
      bool verified}) async {
    Map<String, dynamic> payload = {};

    if (productId != null) payload['product_id'] = productId;
    if (status != null) payload['status'] = status;
    if (reviewer != null) payload['reviewer'] = reviewer;
    if (reviewerEmail != null) payload['reviewer_email'] = reviewerEmail;
    if (review != null) payload['review'] = review;
    if (rating != null) payload['rating'] = rating;
    if (verified != null) payload['verified'] = verified;

    _printLog(payload.toString());
    payload = _standardPayload("post", payload, "products/reviews");

    ProductReview productReview;
    await _apiProvider.post("/request", payload).then((json) {
      productReview = ProductReview.fromJson(json);
    });
    _printLog(productReview.toString());
    return productReview;
  }

  /// https://woosignal.com/docs/api/1.0/customers
  Future<List<Customer>> getCustomers(
      {int page,
      int perPage,
      String search,
      List<int> exclude,
      List<int> include,
      int offset,
      String order,
      String orderBy,
      bool hideEmpty,
      int parent,
      int product,
      String email,
      String slug,
      String role}) async {
    Map<String, dynamic> payload = {};

    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (exclude != null) payload["exclude"] = exclude;
    if (include != null) payload["include"] = include;
    if (offset != null) payload["offset"] = offset;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
    if (hideEmpty != null) payload["hide_empty"] = hideEmpty;
    if (parent != null) payload["parent"] = parent;
    if (product != null) payload["product"] = product;
    if (email != null) payload["email"] = email;
    if (slug != null) payload["slug"] = slug;
    if (role != null) payload["role"] = role;

    _printLog(payload.toString());
    payload = _standardPayload("get", payload, "customers");

    List<Customer> customers = [];
    await _apiProvider.post("/request", payload).then((json) {
      customers = (json as List).map((i) => Customer.fromJson(i)).toList();
    });
    _printLog(customers.toString());
    return customers;
  }

  // https://woocommerce.github.io/woocommerce-rest-api-docs/?php#refunds
  //Refunds
  // Create a refund
  // This API helps you to create a new refund for an order.
  Future<Refund> createRefund({
    @required String amount,
    @required int orderId,
  }) async {
    Map<String, dynamic> payload = {};
    if (amount != null) payload['amount'] = amount;

    _printLog(payload.toString());
    payload = _standardPayload(
        "post", payload, "orders/${orderId.toString()}/refunds");
    Refund refund;
    await _apiProvider.post("/request", payload).then((json) {
      refund = Refund.fromJson(json);
    });
    _printLog(refund.toString());
    return refund;
  }

// Retrieve a refund
// This API lets you retrieve and view a specific refund from an order.
  Future<Refund> retrieveRefund({
    @required int orderId,
    @required int refundId,
    String dp,
  }) async {
    Map<String, dynamic> payload = {};
    if (dp != null) payload["dp"] = dp;
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload,
        "orders/${orderId.toString()}/refunds/${refundId.toString()}");

    Refund refund;
    await _apiProvider.post("/request", payload).then((json) {
      refund = Refund.fromJson(json);
    });
    _printLog(refund.toString());
    return refund;
  }

  // List all refunds
// This API helps you to view all the refunds from an order.
  Future<List<Refund>> getRefunds({
  String context,
    int page,
    int perPage,
    String search,
    String after,
    String before,
    List<int> exclude,
    List<int> include,
    int offset,
    String order,
    String orderby,
    List<int> parent,
    List<int> parentExclude,
    int dp
    }) async {
    Map<String, dynamic> payload = {};
    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (after != null) payload["after"] = after;
    if (before != null) payload["before"] = before;
    if (exclude != null) payload["exclude"] = exclude;
    if (include != null) payload["include"] = include;
    if (offset != null) payload["include"] = offset;
    if (order != null) payload["order"] = order;
    if (orderby != null) payload["orderby"] = orderby;
    if (parent != null) payload["code"] = parent;
    if (parentExclude != null) payload["code"] = parentExclude;
    if (dp != null) payload["code"] = dp;

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload(
        "get", payload, "orders/${orderId.toString()}/refunds");

    List<Refund> refunds = [];
    await _apiProvider.post("/request", payload).then((json) {
      refunds = (json as List).map((i) => Refund.fromJson(i)).toList();
    });
    _printLog(refunds.toString());
    return refunds;
  }

// Delete a refund
// This API helps you delete an order refund.
  Future<Refund> deleteRefund({
    @required int orderId,
    @required int refundId,
  }) async {
  Map<String, dynamic> payload = {};
  payload = _standardPayload("delete", payload,
        "orders/${orderId.toString()}/refunds/${refundId.toString()}");

    Refund refund;
    await _apiProvider.post("/request", payload).then((json) {
      refund = Refund.fromJson(json);
    });
    _printLog(refund.toString());
    return refund;
    }

  /// https://woosignal.com/docs/api/1.0/orders
  Future<List<Order>> getOrders(
      {int page,
      int perPage,
      String search,
      String after,
      String before,
      List<int> exclude,
      List<int> include,
      int offset,
      String order,
      String orderBy,
      List<int> parent,
      List<int> parentExclude,
      List<String>
          status, // Options: any, pending, processing, on-hold, completed, cancelled, refunded, failed and trash. Default is any.
      int customer,
      int product,
      int dp}) async {
    Map<String, dynamic> payload = {};

    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (after != null) payload["after"] = after;
    if (before != null) payload["before"] = before;
    if (exclude != null) payload["exclude"] = exclude;
    if (include != null) payload["include"] = include;
    if (offset != null) payload["offset"] = offset;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
    if (parent != null) payload["parent"] = parent;
    if (parentExclude != null) payload["parent_exclude"] = parentExclude;
    if (status != null) payload["status"] = status;
    if (customer != null) payload["customer"] = customer;
    if (product != null) payload["product"] = product;
    if (dp != null) payload["dp"] = dp;

    _printLog(payload.toString());
    payload = _standardPayload("get", payload, "orders");

    List<Order> orders = [];
    await _apiProvider.post("/request", payload).then((json) {
      orders = (json as List).map((i) => Order.fromJson(i)).toList();
    });
    _printLog(orders.toString());
    return orders;
  }

  /// https://woosignal.com/docs/api/1.0/orders#retrieve-a-order
  Future<Order> retrieveOrder(int id, {String dp}) async {
    Map<String, dynamic> payload = {};
    if (dp != null) payload["dp"] = dp;

    _printLog(payload.toString());
    payload = _standardPayload("get", payload, "orders/" + id.toString());

    Order order;
    await _apiProvider.post("/request", payload).then((json) {
      order = Order.fromJson(json);
    });
    _printLog(order.toString());
    return order;
  }

  /// https://woosignal.com/docs/api/1.0/orders
  Future<Order> updateOrder(int id, {Map<String, dynamic> data}) async {
    Map<String, dynamic> payload = data;

    _printLog(payload.toString());
    payload = _standardPayload("put", payload, "orders/" + id.toString());

    Order order;
    await _apiProvider.post("/request", payload).then((json) {
      order = Order.fromJson(json);
    });
    _printLog(order.toString());
    return order;
  }

  /// https://woosignal.com/docs/api/1.0/orders#create-an-order
  Future<Order> createOrder(OrderWC orderWC) async {
    Map<String, dynamic> payload = orderWC.toJson();

    _printLog(payload.toString());
    payload = _standardPayload("post", payload, "orders");

    Order order;
    await _apiProvider.post("/request", payload).then((json) {
      order = Order.fromJson(json);
    });

    _printLog(order.toString());
    return order;
  }

  /// https://woosignal.com/docs/api/1.0/tax-rates
  Future<List<TaxRate>> getTaxRates(
      {int page,
      int perPage,
      int offset,
      String order,
      String orderBy,
      String taxClass}) async {
    Map<String, dynamic> payload = {};

    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (offset != null) payload["offset"] = offset;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
    if (taxClass != null) payload["taxClass"] = taxClass;

    _printLog(payload.toString());
    payload = _standardPayload("get", payload, "taxes");

    List<TaxRate> taxRates = [];
    await _apiProvider.post("/request", payload).then((json) {
      taxRates = (json as List).map((i) => TaxRate.fromJson(i)).toList();
    });
    _printLog(taxRates.toString());
    return taxRates;
  }

  /// https://woosignal.com/docs/api/1.0/tax-classes
  Future<List<TaxClass>> getTaxClasses() async {
    Map<String, dynamic> payload = {};

    _printLog(payload.toString());
    payload = _standardPayload("get", payload, "taxes/classes");

    List<TaxClass> taxClasses = [];
    await _apiProvider.post("/request", payload).then((json) {
      taxClasses = (json as List).map((i) => TaxClass.fromJson(i)).toList();
    });
    _printLog(taxClasses.toString());
    return taxClasses;
  }

  /// https://woosignal.com/docs/api/1.0/shipping-methods
  Future<List<WSShipping>> getShippingMethods() async {
    Map<String, dynamic> payload = {};

    _printLog(payload.toString());
    payload = _standardPayload("get", payload, "ws/shipping_methods");

    List<WSShipping> shippingMethods = [];
    await _apiProvider.post("/ws/shipping_methods", payload).then((json) {
      shippingMethods =
          (json as List).map((i) => WSShipping.fromJson(i)).toList();
    });
    _printLog(shippingMethods.toString());
    return shippingMethods;
  }

  /// https://woosignal.com/docs/api/1.0/shipping-zones
  Future<List<ShippingZone>> getShippingZones() async {
    Map<String, dynamic> payload = {};
    payload = _standardPayload("get", [], "shipping/zones");

    List<ShippingZone> shippingZones = [];

    await _apiProvider.post("/request", payload).then((json) {
      shippingZones =
          (json as List).map((i) => ShippingZone.fromJson(i)).toList();
    });
    _printLog(shippingZones.toString());
    return shippingZones;
  }

  /// https://woosignal.com/docs/api/1.0/shipping-zones#retrive-a-shipping-zone
  Future<ShippingZone> retrieveShippingZone(int id) async {
    Map<String, dynamic> payload = {};
    payload =
        _standardPayload("get", payload, "shipping/zones/" + id.toString());

    ShippingZone shippingZone;
    await _apiProvider.post("/request", payload).then((json) {
      shippingZone = ShippingZone.fromJson(json);
    });
    _printLog(shippingZone.toString());
    return shippingZone;
  }

  Future<Map<String, dynamic>> stripePaymentIntent(
      {String amount,
      String desc,
      String email,
      Map<String, dynamic> shipping}) async {
    Map<String, dynamic> payload = {
      "amount": amount,
      "receipt_email": email,
      "shipping": shipping,
      "desc": desc,
      "path": "order/pi",
      "type": "post"
    };
    Map<String, dynamic> payloadRsp = {};
    await _apiProvider.post("/order/pi", payload).then((json) {
      payloadRsp = json;
    });
    _printLog(payloadRsp.toString());
    return payloadRsp;
  }

  Future<List<dynamic>> cartCheck(List<Map<String, dynamic>> cartLines) async {
    Map<String, dynamic> payload = {};
    payload = _standardPayload("get", cartLines, "ws/cart_check");

    List<dynamic> payloadRsp = [];
    await _apiProvider.post("/ws/cart_check", payload).then((json) {
      payloadRsp = json;
    });
    _printLog(payloadRsp.toString());
    return payloadRsp;
  }

  Future<dynamic> checkAppStatus() async {
    Map<String, dynamic> payload = {};
    payload = _standardPayload("get", [], "ws/app-status");

    dynamic payloadRsp;
    await _apiProvider.post("/ws/app-status", payload).then((json) {
      payloadRsp = json;
    });
    _printLog(payloadRsp.toString());
    return payloadRsp;
  }

  // Doc link: https://woosignal.com/docs/api/1.0/data
//   List all data
// This API lets you retrieve and view a simple list of available data endpoints.
  Future<ApiData> retrieveApiData() async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "data/");

    ApiData apiData;
    await _apiProvider.post("/request", payload).then((json) {
      apiData = ApiData.fromJson(json);
    });
    _printLog(apiData.toString());
    return apiData;
  }

// List all continents
// This API helps you to view all the continents.
  Future<Continents> retrieveContinentData() async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "data/continents");

    Continents continents;
    await _apiProvider.post("/request", payload).then((json) {
      continents = Continents.fromJson(json);
    });
    _printLog(continents.toString());
    return continents;
  }

//   Retrieve continent data
// This API lets you retrieve and view a continent data.
// Location be like "eu" code For Europe
  Future<Continents> retrieveContinentDatabyLocation(String location) async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload(
        "get", payload, "data/continents/${location.toLowerCase()}");

    Continents continents;
    await _apiProvider.post("/request", payload).then((json) {
      continents = Continents.fromJson(json);
    });
    _printLog(continents.toString());
    return continents;
  }

//   List all countries
// This API helps you to view all the countries.
  Future<List<Countries>> getCountries() async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "data/countries");

    List<Countries> countries = [];
    await _apiProvider.post("/request", payload).then((json) {
      countries = (json as List).map((i) => Countries.fromJson(i)).toList();
    });
    _printLog(countries.toString());
    return countries;
  }

//   Retrieve country data
// This API lets you retrieve and view a country data.
// Location be like "eu" code For Europe
  Future<Countries> retreiveCountryData(String location) async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload(
        "get", payload, "data/countries/${location.toLowerCase()}");

    Countries countryData;
    await _apiProvider.post("/request", payload).then((json) {
      countryData = Countries.fromJson(json);
    });
    _printLog(countryData.toString());
    return countryData;
  }

//   Retrieve current currency
// This API lets you retrieve and view store's current currency data.
  Future<List<Currencies>> getCurrencies() async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "data/currencies");

    List<Currencies> currencies = [];
    await _apiProvider.post("/request", payload).then((json) {
      currencies = (json as List).map((i) => Currencies.fromJson(i)).toList();
    });
    _printLog(currencies.toString());
    return currencies;
  }

// Retrieve currency data
// This API lets you retrieve and view a currency data.
// currency be like "BRL" code For Europe
  Future<Currencies> retreiveCurrencyData(String currency) async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload(
        "get", payload, "data/currencies/${currency.toString()}");

    Currencies currencyData;
    await _apiProvider.post("/request", payload).then((json) {
      currencyData = Currencies.fromJson(json);
    });
    _printLog(currencyData.toString());
    return currencyData;
  }

//   Retrieve current currency
// This API lets you retrieve and view store's current currency data.
  Future<Currencies> retreiveCurrentCurrencyData() async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "data/currencies/current");

    Currencies currencyData;
    await _apiProvider.post("/request", payload).then((json) {
      currencyData = Currencies.fromJson(json);
    });
    _printLog(currencyData.toString());
    return currencyData;
}

//
  // Doc link: https://woosignal.com/docs/api/1.0/payment-gateways
  // Retrieve an payment gateway
// This API lets you retrieve and view a specific payment gateway.
  Future<PaymentGateWay> retrievePaymentGateway({@required String id}) async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload =
        _standardPayload("get", payload, "payment_gateways/${id.toString()}");

    PaymentGateWay paymentGateWay;
    await _apiProvider.post("/request", payload).then((json) {
      paymentGateWay = PaymentGateWay.fromJson(json);
    });
    _printLog(paymentGateWay.toString());
    return paymentGateWay;
  }

// List all payment gateways
// This API helps you to view all the payment gateways.
  Future<List<PaymentGateWay>> getPaymentGateways() async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "payment_gateways");

    List<PaymentGateWay> paymentGateway = [];
    await _apiProvider.post("/request", payload).then((json) {
      paymentGateway =
          (json as List).map((i) => PaymentGateWay.fromJson(i)).toList();
    });
    _printLog(paymentGateway.toString());
    return paymentGateway;
  }

  // Update a payment gateway
// This API lets you make changes to a payment gateway.
  Future<PaymentGateWay> updatePaymentGateway(
      {@required String id, Map<String, dynamic> data}) async {
    Map<String, dynamic> payload = data;
    payload =
        _standardPayload("put", payload, "payment_gateways/${id.toString()}");
    _printLog(payload.toString());

    PaymentGateWay paymentGateWay;
    await _apiProvider.post("/request", payload).then((json) {
      paymentGateWay = PaymentGateWay.fromJson(json);
    });
    _printLog(paymentGateWay.toString());
    return paymentGateWay;
}

// Retrieve an order note
// This API lets you retrieve and view a specific note from an order
  Future<OrderNote> retrieveOrderNote({
    @required int orderId,
    @required int noteId,
  }) async {
    Map<String, dynamic> payload = {};
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload,
        "orders/${orderId.toString()}/notes/${noteId.toString()}");

    OrderNote orderNote;
    await _apiProvider.post("/request", payload).then((json) {
      orderNote = OrderNote.fromJson(json);
    });
    _printLog(orderNote.toString());
    return orderNote;
  }

// https://woocommerce.github.io/woocommerce-rest-api-docs/?php#list-all-order-notes
// List All order notes
// This API helps you to view all the notes from an order.
  Future<List<OrderNote>> getOrderNotes({
    @required int orderId,
    String context,
    String type,
  }) async {
    Map<String, dynamic> payload = {};
    if (type != null) payload["type"] = type;

    _printLog("Parameters: " + payload.toString());
    payload =
        _standardPayload("get", payload, "orders/${orderId.toString()}/notes");

    List<OrderNote> orderNotes = [];
    await _apiProvider.post("/request", payload).then((json) {
      orderNotes = (json as List).map((i) => OrderNote.fromJson(i)).toList();
    });
    _printLog(orderNotes.toString());
    return orderNotes;
  }

// Create an order note
// This API helps you to create a new note for an order.
  Future<OrderNote> createOrderNote({
    @required int id,
    Map<String, dynamic> data,
  }) async {
    Map<String, dynamic> payload = {};
    if (data != null) payload['data'] = data;
    _printLog(payload.toString());
    payload =
        _standardPayload("post", payload, "orders/${id.toString()}/notes");
    OrderNote orderNote;
    await _apiProvider.post("/request", payload).then((json) {
      orderNote = OrderNote.fromJson(json);
    });
    _printLog(orderNote.toString());
    return orderNote;
  }

// Delete an order note
// This API helps you delete an order note.
  Future<OrderNote> deleteOrderNote(
    int orderId,
    int noteId) async {
    Map<String, dynamic> data;
    data = {'force': true};
    Map<String, dynamic> payload = data;

    _printLog(payload.toString());

    // There is the usage of + instead of ${} if error Occurs
    payload = _standardPayload("delete", payload,
        "orders/${orderId.toString()}/notes/${noteId.toString()}");

    OrderNote orderNote;
    await _apiProvider.post("/request", payload).then((json) {
      orderNote = OrderNote.fromJson(json);
    });
    _printLog(orderNote.toString());
    return orderNote;
    }

  Future<Coupon> retrieveCoupons({int id}) async {
    Map<String, dynamic> payload = {};
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "coupons/${id.toString()}");

    Coupon coupon;
    await _apiProvider.post("/request", payload).then((json) {
      coupon = Coupon.fromJson(json);
    });
    _printLog(coupon.toString());
    return coupon;
  }

  // https://woocommerce.github.io/woocommerce-rest-api-docs/#list-all-coupons
// This API helps you to list all the coupons that have been created.
  Future<List<Coupon>> getCoupons({
    String context,
    int page,
    int perPage,
    String search,
    String after,
    String before,
    List<int> exclude,
    List<int> include,
    String order,
    String orderby,
    String code,
  }) async {
    Map<String, dynamic> payload = {};
    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (after != null) payload["after"] = after;
    if (before != null) payload["before"] = before;
    if (exclude != null) payload["exclude"] = exclude;
    if (include != null) payload["include"] = include;
    if (order != null) payload["order"] = order;
    if (orderby != null) payload["orderby"] = orderby;
    if (code != null) payload["code"] = code;

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "coupons");

    List<Coupon> coupons = [];
    await _apiProvider.post("/request", payload).then((json) {
      coupons = (json as List).map((i) => Coupon.fromJson(i)).toList();
    });
    _printLog(coupons.toString());
    return coupons;
  }

  Future<Coupon> createCoupon({
    @required String code,
    @required String discountType,
    @required String amount,
    @required bool individualUse,
    @required bool excludeSaleItems,
    @required String minimumAmount,
  }) async {
    Map<String, dynamic> payload = {};
    if (code != null) payload['code'] = code;
    if (code != null) payload['discount_type'] = discountType;
    if (code != null) payload['amount'] = amount;
    if (code != null) payload['individual_use'] = individualUse;
    if (code != null) payload['exclude_sale_items'] = excludeSaleItems;
    if (code != null) payload['minimum_amount'] = minimumAmount;
    _printLog(payload.toString());
    payload = _standardPayload("post", payload, "coupons/");
    Coupon productCoupon;
    await _apiProvider.post("/request", payload).then((json) {
      productCoupon = Coupon.fromJson(json);
    });
    _printLog(productCoupon.toString());
    return productCoupon;
  }

  Future<Coupon> updateCoupon(int id, {Map<String, dynamic> data}) async {
    Map<String, dynamic> payload = data;

    _printLog(payload.toString());
    payload = _standardPayload("put", payload, "coupons/" + id.toString());

    Coupon coupon;
    await _apiProvider.post("/request", payload).then((json) {
      coupon = Coupon.fromJson(json);
    });
    _printLog(coupon.toString());
    return coupon;
  }

  Future<Coupon> deleteCoupon(
    int id,
  ) async {
    Map<String, dynamic> data;
    Map<String, dynamic> payload = data;

    _printLog(payload.toString());
    payload = _standardPayload("delete", payload, "coupons/" + id.toString());

    Coupon coupon;
    await _apiProvider.post("/request", payload).then((json) {
      coupon = Coupon.fromJson(json);
    });
    _printLog(coupon.toString());
    return coupon;
  }

  // This API helps you to batch create, update and delete multiple coupons.
// Note: By default it's limited to up to 100 objects to be created, updated or deleted.
  Future<CouponBatch> batchCoupon({Map<String, dynamic> data}) async {
    Map<String, dynamic> payload = data;

    _printLog(payload.toString());
    payload = _standardPayload("post", payload, "coupons/batch");

    CouponBatch couponBatch;
    await _apiProvider.post("/request", payload).then((json) {
      couponBatch = CouponBatch.fromJson(json);
    });
    _printLog(couponBatch.toString());
    return couponBatch;
  }

// Retrieve a customer
// This API lets you retrieve and view a specific customer by ID.
  Future<Customers> retrieveCustomer({int id}) async {
    Map<String, dynamic> payload = {};
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "customers/${id.toString()}");

    Customers customers;
    await _apiProvider.post("/request", payload).then((json) {
      customers = Customers.fromJson(json);
    });
    _printLog(customers.toString());
    return customers;
  }

  // Retrieve customer downloads
  // This API lets you retrieve customer downloads permissions.
  Future<Customers> retrieveCustomerDownloads(
      {@required int customerid,
      String downloadId,
      String downloadUrl,
      int productId,
      String productName,
      String downloadName,
      int orderId,
      String orderKey,
      String downloadsRemaining,
      String accessExpires,
      String accessExpiresGmt,
      Map<String, String> file}) async {
    Map<String, dynamic> payload = {};
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload(
        "get", payload, "customers/${customerid.toString()}/downloads");

    Customers customers;
    await _apiProvider.post("/request", payload).then((json) {
      customers = Customers.fromJson(json);
    });
    _printLog(customers.toString());
    return customers;
  }

  // Create a customer
  // This API helps you to create a new customer.
  Future<Customers> createCustomer({
    String email,
    String firstName,
    String lastName,
    String userName,
    Map<String, dynamic> billing,
    Map<String, dynamic> shipping,
  }) async {
    Map<String, dynamic> payload = {};
    if (email != null) payload['email'] = email;
    if (firstName != null) payload['first_name'] = firstName;
    if (lastName != null) payload['last_name'] = lastName;
    if (userName != null) payload['username'] = userName;
    if (billing != null) payload['billing'] = billing;
    if (shipping != null) payload['shipping'] = shipping;
    _printLog(payload.toString());
    payload = _standardPayload("post", payload, "customers/");
    Customers customers;
    await _apiProvider.post("/request", payload).then((json) {
      customers = Customers.fromJson(json);
    });
    _printLog(customers.toString());
    return customers;
  }

// Update a customer
// This API lets you make changes to a customer.
  Future<Customers> updateCustomer(int id, {Map<String, dynamic> data}) async {
    Map<String, dynamic> payload = data;

    _printLog(payload.toString());
    payload = _standardPayload("put", payload, "customers/" + id.toString());

    Customers customers;
    await _apiProvider.post("/request", payload).then((json) {
      customers = Customers.fromJson(json);
    });
    _printLog(customers.toString());
    return customers;
  }

// Delete a customer
// This API helps you delete a customer.
  Future<Customers> deleteCustomer(
    int id,
  ) async {
    Map<String, dynamic> data;
    data = {'force': true};
    Map<String, dynamic> payload = data;

    _printLog(payload.toString());
    payload = _standardPayload("delete", payload, "customers/" + id.toString());

    Customers customers;
    await _apiProvider.post("/request", payload).then((json) {
      customers = Customers.fromJson(json);
    });
    _printLog(customers.toString());
    return customers;
  }

  // This API helps you to batch create, update and delete multiple Customers.
  // This API helps you to batch create, update and delete multiple customers.
// Note: By default it's limited to up to 100 objects to be created, updated or deleted.
  Future<CustomerBatch> batchCustomers({Map<String, dynamic> data}) async {
    Map<String, dynamic> payload = data;

    _printLog(payload.toString());
    payload = _standardPayload("post", payload, "customers/batch");

    CustomerBatch customerBatch;
    await _apiProvider.post("/request", payload).then((json) {
      customerBatch = CustomerBatch.fromJson(json);
    });
    _printLog(customerBatch.toString());
    return customerBatch;
}

// List all reports
// This API helps you to list all the coupons that have been created.
  Future<List<Reports>> getReports() async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "reports");

    List<Reports> reports = [];
    await _apiProvider.post("/request", payload).then((json) {
      reports = (json as List).map((i) => Reports.fromJson(i)).toList();
    });
    _printLog(reports.toString());
    return reports;
  }

// Retrieve sales report
// This API lets you retrieve and view a sales report.
  Future<List<SalesReports>> getSaleReports({
    String context,
    String period,
    String dateMin,
    String dateMax,
  }) async {
    Map<String, dynamic> payload = {};
    if (context != null) payload['context'] = context;
    if (period != null) payload['period'] = period;
    if (dateMin != null) payload['dateMin'] = dateMin;
    if (dateMax != null) payload['dateMax'] = dateMax;
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "reports/sales");

    List<SalesReports> saleReports = [];
    await _apiProvider.post("/request", payload).then((json) {
      saleReports =
          (json as List).map((i) => SalesReports.fromJson(i)).toList();
    });
    _printLog(saleReports.toString());
    return saleReports;
  }

  // Retrieve top sellers report
// This API lets you retrieve and view a list of top sellers report.
  Future<List<TopSellerReport>> getTopSellerReports({
    String context,
    String period,
    String dateMin,
    String dateMax,
  }) async {
    Map<String, dynamic> payload = {};
    if (context != null) payload['context'] = context;
    if (period != null) payload['period'] = period;
    if (dateMin != null) payload['dateMin'] = dateMin;
    if (dateMax != null) payload['dateMax'] = dateMax;
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "reports/top_sellers");

    List<TopSellerReport> topSellerReport = [];
    await _apiProvider.post("/request", payload).then((json) {
      topSellerReport =
          (json as List).map((i) => TopSellerReport.fromJson(i)).toList();
    });
    _printLog(topSellerReport.toString());
    return topSellerReport;
  }

  // Retrieve coupons totals
// This API lets you retrieve and view coupons totals report.
  Future<List<TotalReport>> getTotalCouponsReports() async {
    Map<String, dynamic> payload = {};
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "reports/coupons/totals");

    List<TotalReport> couponReport = [];
    await _apiProvider.post("/request", payload).then((json) {
      couponReport =
          (json as List).map((i) => TotalReport.fromJson(i)).toList();
    });
    _printLog(couponReport.toString());
    return couponReport;
  }

// Retrieve customers totals
// This API lets you retrieve and view customers totals report.
  Future<List<TotalReport>> getTotalCustomerReports() async {
    Map<String, dynamic> payload = {};
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "reports/customers/totals");

    List<TotalReport> customerReport = [];
    await _apiProvider.post("/request", payload).then((json) {
      customerReport =
          (json as List).map((i) => TotalReport.fromJson(i)).toList();
    });
    _printLog(customerReport.toString());
    return customerReport;
  }

// Retrieve orders totals
// This API lets you retrieve and view orders totals report.
  Future<List<TotalReport>> getTotalOrderReports() async {
    Map<String, dynamic> payload = {};
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "reports/orders/totals");

    List<TotalReport> orderReport = [];
    await _apiProvider.post("/request", payload).then((json) {
      orderReport = (json as List).map((i) => TotalReport.fromJson(i)).toList();
    });
    _printLog(orderReport.toString());
    return orderReport;
  }

// Retrieve products totals
// This API lets you retrieve and view products totals report.
  Future<List<TotalReport>> getTotalProductReports() async {
    Map<String, dynamic> payload = {};
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "reports/products/totals");

    List<TotalReport> productReport = [];
    await _apiProvider.post("/request", payload).then((json) {
      productReport =
          (json as List).map((i) => TotalReport.fromJson(i)).toList();
    });
    _printLog(productReport.toString());
    return productReport;
  }

// Retrieve reviews totals
// This API lets you retrieve and view reviews totals report.
  Future<List<TotalReport>> getTotalReviewReports() async {
    Map<String, dynamic> payload = {};
    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "reports/reviews/totals");

    List<TotalReport> reviewReport = [];
    await _apiProvider.post("/request", payload).then((json) {
      reviewReport =
          (json as List).map((i) => TotalReport.fromJson(i)).toList();
    });
    _printLog(reviewReport.toString());
    return reviewReport;
}

  // Doc link: https://woosignal.com/docs/api/1.0/system-status
  Future<SystemStatus> getSystemStatus() async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload("get", payload, "system_status/");

    SystemStatus systemStatus;
    await _apiProvider.post("/request", payload).then((json) {
      systemStatus = SystemStatus.fromJson(json);
    });
    _printLog(systemStatus.toString());
    return systemStatus;
  }

  // Delete an Order
// This API helps you delete an Order.
  Future<Orders> deleteOrder(
    int id,
  ) async {
    Map<String, dynamic> data;
    data = {'force': true};
    Map<String, dynamic> payload = data;
    _printLog(payload.toString());
    payload = _standardPayload("delete", payload, "orders/" + id.toString());

    Orders order;
    await _apiProvider.post("/request", payload).then((json) {
      order = Orders.fromJson(json);
    });
    _printLog(order.toString());
    return order;
  }

  // This API helps you to batch create, update and delete multiple Orders.
  // This API helps you to batch create, update and delete multiple Orders.
// Note: By default it's limited to up to 100 objects to be created, updated or deleted.
  Future<OrderBatch> batchOrders({Map<String, dynamic> data}) async {
    Map<String, dynamic> payload = data;

    _printLog(payload.toString());
    payload = _standardPayload("post", payload, "orders/batch");

    OrderBatch orderBatch;
    await _apiProvider.post("/request", payload).then((json) {
      orderBatch = OrderBatch.fromJson(json);
    });
    _printLog(orderBatch.toString());
    return orderBatch;
  }
}

// Doc link: https://woosignal.com/docs/api/1.0/setting-options
// Retrieve a setting option
// This API lets you retrieve and view a specific setting option.

  Future<SettingOption> retrieveSettingOptions(
      {@required String groupid, @required String id}) async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload = _standardPayload(
        "get", payload, "settings/${groupid.toString()}/${id.toString()}");

    SettingOption settingOption;
    await _apiProvider.post("/request", payload).then((json) {
      settingOption = SettingOption.fromJson(json);
    });
    _printLog(settingOption.toString());
    return settingOption;
  }

// Retrieve a setting option
// This API lets you retrieve and view a specific setting option.
  Future<List<SettingOption>> getSettingOptions({String groupId}) async {
    Map<String, dynamic> payload = {};

    _printLog("Parameters: " + payload.toString());
    payload =
        _standardPayload("get", payload, "settings/${groupId.toString()}");

    List<SettingOption> settingOptions = [];
    await _apiProvider.post("/request", payload).then((json) {
      settingOptions =
          (json as List).map((i) => SettingOption.fromJson(i)).toList();
    });
    _printLog(settingOptions.toString());
    return settingOptions;
  }

//   Update a setting option
// This API lets you make changes to a setting option.
  Future<SettingOption> updateSettinOptions(String groupid, String id,
      {Map<String, dynamic> data}) async {
    Map<String, dynamic> payload = data;

    _printLog(payload.toString());
    payload = _standardPayload(
        "put", payload, "settings/${groupid.toString()}/${id.toString}");

    SettingOption settingOption;
    await _apiProvider.post("/request", payload).then((json) {
      settingOption = SettingOption.fromJson(json);
    });
    _printLog(settingOption.toString());
    return settingOption;
  }
//   Batch update setting options
// This API helps you to batch update multiple setting options.

//  Note: By default it's limited to up to 100 objects to be created, updated or deleted.
  Future<SettingOptionBatch> batchSettingOptions(
      {Map<String, dynamic> data}) async {
    Map<String, dynamic> payload = data;

    _printLog(payload.toString());
    payload = _standardPayload("post", payload, "settings/general/batch");

    SettingOptionBatch batchsettingOption;
    await _apiProvider.post("/request", payload).then((json) {
      batchsettingOption = SettingOptionBatch.fromJson(json);
    });
    _printLog(batchsettingOption.toString());
    return batchsettingOption;
  }
}
