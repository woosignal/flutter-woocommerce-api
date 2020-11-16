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

import 'package:flutter/cupertino.dart';
import 'package:woosignal/models/response/coupon.dart';
import 'package:woosignal/models/response/coupon_batch.dart';
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
}
