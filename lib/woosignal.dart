library woosignal;

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

import 'dart:convert';

import 'package:woosignal/models/response/api_data.dart';
import 'package:woosignal/models/response/continent.dart';
import 'package:woosignal/models/response/currencies.dart';
import 'package:woosignal/models/response/customer_download.dart';
import 'package:woosignal/models/response/order_batch.dart' as ob;
import 'package:woosignal/models/response/product_tag.dart';
import 'package:woosignal/models/response/refund.dart';
import 'package:woosignal/models/response/order_notes.dart';
import 'package:woosignal/models/response/coupon.dart';
import 'package:woosignal/models/response/coupon_batch.dart';
import 'package:woosignal/models/response/customer_batch.dart';
import 'package:woosignal/models/response/reports.dart';
import 'package:woosignal/models/response/woosignal_app.dart';
import 'package:woosignal/networking/api_provider.dart';
import 'package:woosignal/models/response/product.dart';
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
import 'package:woosignal/models/response/sale_report.dart';
import 'package:woosignal/models/response/top_seller_report.dart';
import 'package:woosignal/models/response/system_status.dart';
import 'package:woosignal/models/response/setting_option.dart';
import 'package:woosignal/models/response/setting_option_batch.dart';
import 'package:woosignal/models/response/product_batch.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:encrypt/encrypt.dart';

/// WooSignal Package version
const String wooSignalVersion = "3.8.0";

class WooSignal {
  WooSignal._privateConstructor();
  static final WooSignal instance = WooSignal._privateConstructor();

  late ApiProvider _apiProvider;
  bool? _debugMode;
  String? _encryptKey, _encryptSecret;

  /// Initialize the class
  Future<void> init(
      {required String? appKey,
      bool debugMode = false,
      String? encryptKey,
      String? encryptSecret}) async {
    assert(appKey != null && appKey != "",
        "Provide a valid app key. Visit https://woosignal.com");
    _apiProvider = ApiProvider(
        appKey: appKey!, debugMode: debugMode, version: wooSignalVersion);
    setDebugMode(debugMode);
    if (encryptKey != null) {
      _encryptKey = encryptKey;
    }
    if (encryptSecret != null) {
      _encryptSecret = encryptSecret;
    }
    await _apiProvider.init();
  }

  /// Set the FCM token for notifications
  void setFcmToken(String token) {
    _apiProvider.setFcmToken(token);
  }

  /// Enable debug mode for logging information
  void setDebugMode(bool debugMode) {
    _debugMode = debugMode;
    _apiProvider.setDebugMode(debugMode);
  }

  /// Print to the console a [message]
  void _printLog(String message) {
    if (_debugMode == true) {
      print("WooSignal LOG: $message");
    }
  }

  Map<String, dynamic> _standardPayload(String type, json, String path) =>
      {"type": type, "payload": json, "path": path};

  /// WooSignal Request
  Future<T?> _wooSignalRequest<T>(
      {dynamic payload = const {},
      required String method,
      required String path,
      required T Function(dynamic json) jsonResponse,
      String postUrl = "/request"}) async {
    _printLog("Parameters: $payload");
    payload = _standardPayload(method, payload, path);

    dynamic json = await _apiProvider.post(postUrl, payload);
    if (json is Map<String, dynamic> && json.containsKey('error')) {
      _printLog(json['error']);
      return null;
    }

    T model;
    try {
      model = jsonResponse(json);
    } on Exception catch (e) {
      _printLog(e.toString());
      return null;
    }

    _printLog(model.toString());
    return model;
  }

  String encrypt(String text) {
    if (_encryptKey == null) {
      return "";
    }
    if (_encryptSecret == null) {
      return "";
    }
    final key = enc.Key.fromUtf8(_encryptKey!);
    final iv = IV.fromUtf8(_encryptSecret!);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(text, iv: iv);
    return encrypted.base64;
  }

  String decrypt(String text) {
    if (_encryptKey == null) {
      return "";
    }
    if (_encryptSecret == null) {
      return "";
    }
    final key = enc.Key.fromUtf8(_encryptKey!);
    final iv = IV.fromUtf8(_encryptSecret!);
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final decrypted = encrypter.decrypt(Encrypted.fromBase64(text), iv: iv);
    return decrypted;
  }

  /// Get app information from WooSignal
  Future<WooSignalApp?> getApp({bool encrypted = false}) async {
    dynamic response =
        await _apiProvider.get("/app", data: {"encrypted": encrypted});
    if (response == null) {
      return null;
    }
    if (encrypted == true) {
      response = jsonDecode(decrypt(response));
    }
    WooSignalApp wooSignalApp = WooSignalApp.fromJson(response);
    _printLog(wooSignalApp.toString());
    return wooSignalApp;
  }

  /// https://woosignal.com/docs/api/1.0/products
  Future<List<Product>> getProducts(
      {int? page,
      int? perPage,
      String? search,
      String? after,
      String? before,
      String? order,
      String? orderBy,
      String? slug,
      String? status,
      String? type,
      String? sku,
      String? category,
      String? tag,
      String? shippingClass,
      String? attribute,
      String? attributeTerm,
      String? taxClass,
      String? minPrice,
      String? maxPrice,
      String? stockStatus,
      List<int>? exclude,
      List<int>? parentExclude,
      List<int>? include,
      List<int>? parent,
      int? offset,
      bool? featured,
      bool? onSale}) async {
    Map<String, dynamic> payload = {};
    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (after != null) payload["after"] = after;
    if (before != null) payload["before"] = before;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
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

    return await _wooSignalRequest<List<Product>>(
          method: "get",
          payload: payload,
          path: "products",
          jsonResponse: (json) =>
              (json as List).map((i) => Product.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/products#retrive-a-product-api-call
  Future<Product?> retrieveProduct({required int id}) async {
    return await _wooSignalRequest<Product?>(
      method: "get",
      path: "products/${id.toString()}",
      jsonResponse: (json) => Product.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/products-variations
  Future<List<ProductVariation>> getProductVariations(int productId,
      {int? page,
      int? perPage,
      String? search,
      String? after,
      String? before,
      List<int>? exclude,
      List<int>? include,
      int? offset,
      String? order,
      String? orderBy,
      List<int>? parent,
      List<int>? parentExclude,
      String? slug,
      String? status,
      String? sku,
      String? taxClass,
      bool? onSale,
      String? minPrice,
      String? maxPrice,
      String? stockStatus}) async {
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

    return await _wooSignalRequest<List<ProductVariation>>(
          method: "get",
          payload: payload,
          path: "products/$productId/variations",
          jsonResponse: (json) =>
              (json as List).map((i) => ProductVariation.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/products-attributes
  Future<List<ProductAttribute>> getProductAttributes() async {
    return await _wooSignalRequest<List<ProductAttribute>>(
          method: "get",
          path: "products/attributes",
          jsonResponse: (json) =>
              (json as List).map((i) => ProductAttribute.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/products-attribute-terms
  Future<List<ProductAttributeTerm>> getProductAttributeTerms(int attributeId,
      {int? page,
      int? perPage,
      String? search,
      List<int>? exclude,
      List<int>? include,
      String? order,
      String? orderBy,
      bool? hideEmpty,
      int? parent,
      int? product,
      String? slug}) async {
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

    return await _wooSignalRequest<List<ProductAttributeTerm>>(
          method: "get",
          payload: payload,
          path: "products/attributes/$attributeId/terms",
          jsonResponse: (json) => (json as List)
              .map((i) => ProductAttributeTerm.fromJson(i))
              .toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/product-categories
  Future<List<ProductCategory>> getProductCategories(
      {int? page,
      int? perPage,
      String? search,
      List<int>? exclude,
      List<int>? include,
      String? order,
      String? orderBy,
      bool? hideEmpty,
      int? parent,
      int? product,
      String? slug}) async {
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

    return await _wooSignalRequest<List<ProductCategory>>(
          method: "get",
          payload: payload,
          path: "products/categories",
          jsonResponse: (json) =>
              (json as List).map((i) => ProductCategory.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/product-shipping-classes
  Future<List<ProductShippingClass>> getProductShippingClasses(
      {int? page,
      int? perPage,
      String? search,
      List<int>? exclude,
      List<int>? include,
      int? offset,
      String? order,
      String? orderBy,
      bool? hideEmpty,
      int? product,
      String? slug}) async {
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

    return await _wooSignalRequest<List<ProductShippingClass>>(
          method: "get",
          payload: payload,
          path: "products/shipping_classes",
          jsonResponse: (json) => (json as List)
              .map((i) => ProductShippingClass.fromJson(i))
              .toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/product-reviews
  Future<List<ProductReview>> getProductReviews(
      {int? page,
      int? perPage,
      String? search,
      String? after,
      String? before,
      List<int>? exclude,
      List<int>? include,
      int? offset,
      String? order,
      String? orderBy,
      List<int>? reviewer,
      List<int>? reviewerExclude,
      List<String>? reviewerEmail,
      List<int>? product,
      String? status}) async {
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

    return await _wooSignalRequest<List<ProductReview>>(
          method: "get",
          payload: payload,
          path: "products/reviews",
          jsonResponse: (json) =>
              (json as List).map((i) => ProductReview.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/product-reviews
  Future<ProductReview?> createProductReview(
      {int? productId,
      String? status,
      String? reviewer,
      String? reviewerEmail,
      String? review,
      int? rating, // Review rating (0 to 5)
      bool? verified}) async {
    Map<String, dynamic> payload = {};

    if (productId != null) payload['product_id'] = productId;
    if (status != null) payload['status'] = status;
    if (reviewer != null) payload['reviewer'] = reviewer;
    if (reviewerEmail != null) payload['reviewer_email'] = reviewerEmail;
    if (review != null) payload['review'] = review;
    if (rating != null) payload['rating'] = rating;
    if (verified != null) payload['verified'] = verified;

    return await _wooSignalRequest<ProductReview?>(
      method: "post",
      payload: payload,
      path: "products/reviews",
      jsonResponse: (json) => ProductReview.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/customers
  Future<List<Customer>> getCustomers(
      {int? page,
      int? perPage,
      String? search,
      List<int>? exclude,
      List<int>? include,
      int? offset,
      String? order,
      String? orderBy,
      bool? hideEmpty,
      int? parent,
      int? product,
      String? email,
      String? slug,
      String? role}) async {
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

    return await _wooSignalRequest<List<Customer>>(
          method: "get",
          payload: payload,
          path: "customers",
          jsonResponse: (json) =>
              (json as List).map((i) => Customer.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/refunds#create-a-refund
  Future<Refund?> createRefund({
    required String amount,
    required int orderId,
  }) async {
    Map<String, dynamic> payload = {'amount': amount};

    return await _wooSignalRequest<Refund?>(
      method: "post",
      payload: payload,
      path: "orders/${orderId.toString()}/refunds",
      jsonResponse: (json) => Refund.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/refunds#retrieve-a-refund
  Future<Refund?> retrieveRefund({
    required int orderId,
    required int refundId,
    String? dp,
  }) async {
    Map<String, dynamic> payload = {};
    if (dp != null) payload["dp"] = dp;

    return await _wooSignalRequest<Refund?>(
      method: "get",
      payload: payload,
      path: "orders/${orderId.toString()}/refunds/${refundId.toString()}",
      jsonResponse: (json) => Refund.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/refunds#list-all-refunds
  Future<List<Refund>> getRefunds(int orderId,
      {String? context,
      int? page,
      int? perPage,
      String? search,
      String? after,
      String? before,
      List<int>? exclude,
      List<int>? include,
      int? offset,
      String? order,
      String? orderby,
      List<int>? parent,
      List<int>? parentExclude,
      int? dp}) async {
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

    return await _wooSignalRequest<List<Refund>>(
          method: "get",
          payload: payload,
          path: "orders/${orderId.toString()}/refunds",
          jsonResponse: (json) =>
              (json as List).map((i) => Refund.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/refunds#delete-a-refund
  Future<Refund?> deleteRefund({
    required int orderId,
    required int refundId,
  }) async {
    return await _wooSignalRequest<Refund?>(
      method: "delete",
      path: "orders/${orderId.toString()}/refunds/${refundId.toString()}",
      jsonResponse: (json) => Refund.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/orders
  Future<List<Order>> getOrders(
      {int? page,
      int? perPage,
      String? search,
      String? after,
      String? before,
      String? modifiedAfter,
      String? modifiedBefore,
      List<int>? exclude,
      List<int>? include,
      int? offset,
      String? order,
      String? orderBy,
      List<int>? parent,
      List<int>? parentExclude,
      List<String> status = const [
        "any"
      ], // Options: any, pending, processing, on-hold, completed, cancelled, refunded, failed and trash. Default is any.
      int? customer,
      int? product,
      int? dp}) async {
    Map<String, dynamic> payload = {};

    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (search != null) payload["search"] = search;
    if (after != null) payload["after"] = after;
    if (before != null) payload["before"] = before;
    if (modifiedAfter != null) payload["modified_after"] = modifiedAfter;
    if (modifiedBefore != null) payload["modified_before"] = modifiedBefore;
    if (exclude != null) payload["exclude"] = exclude;
    if (include != null) payload["include"] = include;
    if (offset != null) payload["offset"] = offset;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
    if (parent != null) payload["parent"] = parent;
    if (parentExclude != null) payload["parent_exclude"] = parentExclude;
    payload["status"] = status;
    if (customer != null) payload["customer"] = customer;
    if (product != null) payload["product"] = product;
    if (dp != null) payload["dp"] = dp;

    return await _wooSignalRequest<List<Order>>(
          method: "get",
          path: "orders",
          payload: payload,
          jsonResponse: (json) =>
              (json as List).map((i) => Order.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/orders#retrieve-a-order
  Future<Order?> retrieveOrder(int id, {String? dp}) async {
    Map<String, dynamic> payload = {};
    if (dp != null) payload["dp"] = dp;

    return await _wooSignalRequest<Order?>(
      method: "get",
      path: "orders/$id",
      payload: payload,
      jsonResponse: (json) => Order.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/orders
  Future<Order?> updateOrder(int id,
      {required Map<String, dynamic> data}) async {
    return await _wooSignalRequest<Order?>(
      method: "put",
      path: "orders/$id",
      payload: data,
      jsonResponse: (json) => Order.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/orders#create-an-order
  Future<Order?> createOrder(OrderWC orderWC) async {
    return await _wooSignalRequest<Order?>(
      method: "post",
      path: "orders",
      payload: orderWC.toJson(),
      jsonResponse: (json) => Order.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/tax-rates
  Future<List<TaxRate>> getTaxRates(
      {int? page,
      int? perPage,
      int? offset,
      String? order,
      String? orderBy,
      String? taxClass}) async {
    Map<String, dynamic> payload = {};

    if (page != null) payload["page"] = page;
    if (perPage != null) payload["per_page"] = perPage;
    if (offset != null) payload["offset"] = offset;
    if (order != null) payload["order"] = order;
    if (orderBy != null) payload["orderby"] = orderBy;
    if (taxClass != null) payload["taxClass"] = taxClass;

    return await _wooSignalRequest<List<TaxRate>>(
          method: "get",
          path: "taxes",
          payload: payload,
          jsonResponse: (json) =>
              (json as List).map((i) => TaxRate.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/tax-classes
  Future<List<TaxClass>> getTaxClasses() async {
    return await _wooSignalRequest<List<TaxClass>>(
          method: "get",
          path: "taxes/classes",
          jsonResponse: (json) =>
              (json as List).map((i) => TaxClass.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/shipping-methods
  Future<List<WSShipping>> getShippingMethods() async {
    return await _wooSignalRequest<List<WSShipping>>(
          method: "get",
          path: "ws/shipping_methods",
          postUrl: "/ws/shipping_methods",
          jsonResponse: (json) =>
              (json as List).map((i) => WSShipping.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/shipping-zones
  Future<List<ShippingZone>> getShippingZones() async {
    return await _wooSignalRequest<List<ShippingZone>>(
          method: "get",
          path: "shipping/zones",
          jsonResponse: (json) =>
              (json as List).map((i) => ShippingZone.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/shipping-zones#retrive-a-shipping-zone
  Future<ShippingZone?> retrieveShippingZone(int id) async {
    return await _wooSignalRequest<ShippingZone?>(
      method: "get",
      path: "shipping/zones/$id",
      jsonResponse: (json) => ShippingZone.fromJson(json),
    );
  }

  /// Creates a new payment intent
  Future<Map<String, dynamic>?> stripePaymentIntent(
      {String? amount,
      String? desc,
      String? email,
      Map<String, dynamic>? shipping}) async {
    Map<String, dynamic> payload = {
      "amount": amount,
      "receipt_email": email,
      "shipping": shipping,
      "desc": desc,
      "path": "order/pi",
      "type": "post"
    };
    Map<String, dynamic>? payloadRsp = {};
    await _apiProvider.post("/order/pi", payload).then((json) {
      payloadRsp = json;
    });
    _printLog(payloadRsp.toString());
    return payloadRsp;
  }

  /// Creates a new payment intent and save details
  Future<Map<String, dynamic>?> stripePaymentIntentV2({
    String? amount,
    String? desc,
    String? email,
    Map<String, dynamic>? shipping,
    Map<String, dynamic>? customerDetails,
  }) async {
    Map<String, dynamic> payload = {
      "amount": amount,
      "receipt_email": email,
      "shipping": shipping,
      "desc": desc,
      "path": "order/v2/pi",
      "type": "post",
      "customer_details": customerDetails,
    };
    Map<String, dynamic>? payloadRsp =
        await _apiProvider.post("/order/v2/pi", payload);

    _printLog(payloadRsp.toString());
    return payloadRsp;
  }

  /// Check if the cart items are in stock and returns the users cart
  Future<List<dynamic>?> cartCheck(List<Map<String, dynamic>> cartLines) async {
    return await _wooSignalRequest<List<dynamic>?>(
      method: "get",
      path: "ws/cart_check",
      payload: cartLines,
      postUrl: "/ws/cart_check",
      jsonResponse: (json) => json,
    );
  }

  /// checks if the app can make orders
  Future<bool> checkAppStatus() async {
    return await _wooSignalRequest<bool>(
          method: "get",
          path: "ws/app-status",
          postUrl: "/ws/app-status",
          jsonResponse: (json) =>
              (json['status'] == "200" && json['result']['value'] == 1)
                  ? true
                  : false,
        ) ??
        false;
  }

  /// https://woosignal.com/docs/api/1.0/data#list-all-data
  Future<ApiData?> retrieveApiData() async {
    return await _wooSignalRequest<ApiData?>(
      method: "get",
      path: "data",
      jsonResponse: (json) => ApiData.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/data#list-all-continents
  Future<Continents?> getContinentData() async {
    return await _wooSignalRequest<Continents?>(
      method: "get",
      path: "data/continents",
      jsonResponse: (json) => Continents.fromJson(json),
    );
  }

  // Location be like "eu" code For Europe
  /// https://woosignal.com/docs/api/1.0/data#retrieve-continent-data
  Future<Continents?> retrieveContinentDataByLocation(String location) async {
    return await _wooSignalRequest<Continents?>(
      method: "get",
      path: "data/continents/${location.toLowerCase()}",
      jsonResponse: (json) => Continents.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/data#list-all-countries
  Future<List<Countries>> getCountries() async {
    return await _wooSignalRequest<List<Countries>>(
          method: "get",
          path: "data/countries",
          jsonResponse: (json) =>
              (json as List).map((i) => Countries.fromJson(i)).toList(),
        ) ??
        [];
  }

  // Location be like "eu" code For Europe
  /// https://woosignal.com/docs/api/1.0/data#retrieve-country-data
  Future<Countries?> retrieveCountryData(String location) async {
    return await _wooSignalRequest<Countries?>(
      method: "get",
      path: "data/countries/${location.toLowerCase()}",
      jsonResponse: (json) => Countries.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/data#list-all-currencies
  Future<List<Currencies>> getCurrencies() async {
    return await _wooSignalRequest<List<Currencies>>(
          method: "get",
          path: "data/currencies",
          jsonResponse: (json) =>
              (json as List).map((i) => Currencies.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/data#retrieve-currency-data
  Future<Currencies?> retrieveCurrencyData(String currency) async {
    return await _wooSignalRequest<Currencies?>(
      method: "get",
      path: "data/currencies/${currency.toString()}",
      jsonResponse: (json) => Currencies.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/data#retrieve-current-currency
  Future<Currencies?> retrieveCurrentCurrencyData() async {
    return await _wooSignalRequest<Currencies?>(
      method: "get",
      path: "data/currencies/current",
      jsonResponse: (json) => Currencies.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/payment-gateways#retrieve-an-payment-gateway
  Future<PaymentGateWay?> retrievePaymentGateway({required String id}) async {
    return await _wooSignalRequest<PaymentGateWay?>(
      method: "get",
      path: "payment_gateways/${id.toString()}",
      jsonResponse: (json) => PaymentGateWay.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/payment-gateways#list-all-payment-gateways
  Future<List<PaymentGateWay>> getPaymentGateways() async {
    return await _wooSignalRequest<List<PaymentGateWay>>(
          method: "get",
          path: "payment_gateways",
          jsonResponse: (json) =>
              (json as List).map((i) => PaymentGateWay.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/payment-gateways#update-a-payment-gateway
  Future<PaymentGateWay?> updatePaymentGateway(
      {required String id, Map<String, dynamic>? data}) async {
    return await _wooSignalRequest<PaymentGateWay?>(
      method: "put",
      payload: data,
      path: "payment_gateways/${id.toString()}",
      jsonResponse: (json) => PaymentGateWay.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/order-notes#retrieve-an-order-note
  Future<OrderNote?> retrieveOrderNote({
    required int orderId,
    required int noteId,
  }) async {
    return await _wooSignalRequest<OrderNote?>(
      method: "get",
      path: "orders/${orderId.toString()}/notes/${noteId.toString()}",
      jsonResponse: (json) => OrderNote.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/order-notes#list-all-order-notes
  Future<List<OrderNote>> getOrderNotes({
    required int orderId,
    String? context,
    String? type,
  }) async {
    Map<String, dynamic> payload = {};
    if (type != null) payload["type"] = type;

    return await _wooSignalRequest<List<OrderNote>>(
          method: "get",
          path: "orders/${orderId.toString()}/notes",
          payload: payload,
          jsonResponse: (json) =>
              (json as List).map((i) => OrderNote.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/order-notes#create-an-order-note
  Future<OrderNote?> createOrderNote({
    required int id,
    required Map<String, dynamic> data,
  }) async {
    return await _wooSignalRequest<OrderNote?>(
      method: "post",
      path: "orders/${id.toString()}/notes",
      payload: data,
      jsonResponse: (json) => OrderNote.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/order-notes#delete-an-order-note
  Future<OrderNote?> deleteOrderNote(int orderId, int noteId,
      {bool force = false}) async {
    Map<String, dynamic> payload = {"force": force};
    return await _wooSignalRequest<OrderNote?>(
      method: "delete",
      path: "orders/${orderId.toString()}/notes/${noteId.toString()}",
      payload: payload,
      jsonResponse: (json) => OrderNote.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/coupons#retrieve-a-coupon
  Future<Coupon?> retrieveCoupon({required int? id}) async {
    return await _wooSignalRequest<Coupon?>(
      method: "get",
      path: "coupons/${id.toString()}",
      jsonResponse: (json) => Coupon.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/coupons#list-all-coupons
  Future<List<Coupon>> getCoupons({
    String? context,
    int? page,
    int? perPage,
    String? search,
    String? after,
    String? before,
    List<int>? exclude,
    List<int>? include,
    String? order,
    String? orderby,
    String? code,
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

    return await _wooSignalRequest<List<Coupon>>(
          method: "get",
          path: "coupons",
          payload: payload,
          jsonResponse: (json) =>
              (json as List).map((i) => Coupon.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/coupons#create-a-coupon
  Future<Coupon?> createCoupon(
      {required String? code,
      required String? discountType,
      required String? amount,
      required bool? individualUse,
      required bool? excludeSaleItems,
      required String? minimumAmount,
      int? usageLimit,
      List<int>? productIds,
      List<String>? emailRestrictions,
      String? description}) async {
    Map<String, dynamic> payload = {};
    if (code != null) payload['code'] = code;
    if (discountType != null) payload['discount_type'] = discountType;
    if (amount != null) payload['amount'] = amount;
    if (individualUse != null) payload['individual_use'] = individualUse;
    if (excludeSaleItems != null) {
      payload['exclude_sale_items'] = excludeSaleItems;
    }
    if (minimumAmount != null) payload['minimum_amount'] = minimumAmount;
    if (usageLimit != null) payload['usage_limit'] = usageLimit;
    if (productIds != null) payload['product_ids'] = productIds;
    if (emailRestrictions != null) {
      payload['email_restrictions'] = emailRestrictions;
    }
    if (description != null) payload['description'] = description;

    return await _wooSignalRequest<Coupon?>(
      method: "post",
      path: "coupons",
      payload: payload,
      jsonResponse: (json) => Coupon.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/coupons#update-a-coupon
  Future<Coupon?> updateCoupon(int id,
      {required Map<String, dynamic> data}) async {
    return await _wooSignalRequest<Coupon?>(
      method: "put",
      path: "coupons/$id",
      payload: data,
      jsonResponse: (json) => Coupon.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/coupons#delete-a-coupon
  Future<Coupon?> deleteCoupon(int id, {bool force = false}) async {
    return await _wooSignalRequest<Coupon?>(
      method: "delete",
      path: "coupons/$id",
      payload: {'force': force},
      jsonResponse: (json) => Coupon.fromJson(json),
    );
  }

  // Note: By default it's limited to up to 100 objects to be created, updated or deleted.
  /// https://woosignal.com/docs/api/1.0/customers#batch-update-coupons
  Future<CouponBatch?> batchCoupon({required Map<String, dynamic> data}) async {
    return await _wooSignalRequest<CouponBatch?>(
      method: "post",
      path: "coupons/batch",
      payload: data,
      jsonResponse: (json) => CouponBatch.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/customers#retrieve-a-customer
  Future<Customers?> retrieveCustomer({required int id}) async {
    return await _wooSignalRequest<Customers?>(
      method: "get",
      path: "customers/${id.toString()}",
      jsonResponse: (json) => Customers.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/customers#retrieve-customer-downloads
  Future<List<CustomerDownload>?> retrieveCustomerDownloads(
      {required int customerId}) async {
    return await _wooSignalRequest<List<CustomerDownload>?>(
      method: "get",
      path: "customers/${customerId.toString()}/downloads",
      jsonResponse: (json) =>
          (json as List).map((i) => CustomerDownload.fromJson(i)).toList(),
    );
  }

  /// https://woosignal.com/docs/api/1.0/customers#create-a-customer
  Future<Customers?> createCustomer({
    String? email,
    String? firstName,
    String? lastName,
    String? userName,
    Map<String, dynamic>? billing,
    Map<String, dynamic>? shipping,
  }) async {
    Map<String, dynamic> payload = {};
    if (email != null) payload['email'] = email;
    if (firstName != null) payload['first_name'] = firstName;
    if (lastName != null) payload['last_name'] = lastName;
    if (userName != null) payload['username'] = userName;
    if (billing != null) payload['billing'] = billing;
    if (shipping != null) payload['shipping'] = shipping;

    return await _wooSignalRequest<Customers?>(
      method: "post",
      path: "customers",
      payload: payload,
      jsonResponse: (json) => Customers.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/customers#update-a-customer
  Future<Customers?> updateCustomer(int id,
      {required Map<String, dynamic> data}) async {
    return await _wooSignalRequest<Customers?>(
      method: "put",
      path: "customers/$id",
      payload: data,
      jsonResponse: (json) => Customers.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/customers#delete-a-customer
  Future<Customers?> deleteCustomer(int id, {bool force = false}) async {
    Map<String, dynamic> payload = {'force': force};

    return await _wooSignalRequest<Customers?>(
      method: "delete",
      path: "customers/$id",
      payload: payload,
      jsonResponse: (json) => Customers.fromJson(json),
    );
  }

  // Note: By default it's limited to up to 100 objects to be created, updated or deleted.
  /// https://woosignal.com/docs/api/1.0/customers#batch-update-customers
  Future<CustomerBatch?> batchCustomers(
      {required Map<String, dynamic> data}) async {
    return await _wooSignalRequest<CustomerBatch?>(
      method: "post",
      path: "customers/batch",
      payload: data,
      jsonResponse: (json) => CustomerBatch.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/reports#list-all-reports
  Future<List<Reports>> getReports() async {
    return await _wooSignalRequest<List<Reports>>(
          method: "get",
          path: "reports",
          jsonResponse: (json) =>
              (json as List).map((i) => Reports.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/reports#retrieve-sales-report
  Future<List<SalesReports>> getSaleReports({
    String? context,
    String? period,
    String? dateMin,
    String? dateMax,
  }) async {
    Map<String, dynamic> payload = {};
    if (context != null) payload['context'] = context;
    if (period != null) payload['period'] = period;
    if (dateMin != null) payload['dateMin'] = dateMin;
    if (dateMax != null) payload['dateMax'] = dateMax;

    return await _wooSignalRequest<List<SalesReports>>(
          method: "get",
          path: "reports/sales",
          payload: payload,
          jsonResponse: (json) =>
              (json as List).map((i) => SalesReports.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/reports#retrieve-top-sellers-report
  Future<List<TopSellerReport>> getTopSellerReports({
    String? context,
    String? period,
    String? dateMin,
    String? dateMax,
  }) async {
    Map<String, dynamic> payload = {};
    if (context != null) payload['context'] = context;
    if (period != null) payload['period'] = period;
    if (dateMin != null) payload['dateMin'] = dateMin;
    if (dateMax != null) payload['dateMax'] = dateMax;

    return await _wooSignalRequest<List<TopSellerReport>>(
          method: "get",
          path: "reports/top_sellers",
          payload: payload,
          jsonResponse: (json) =>
              (json as List).map((i) => TopSellerReport.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/reports#retrieve-coupons-totals
  Future<List<TotalReport>> getTotalCouponsReports() async {
    return await _wooSignalRequest<List<TotalReport>>(
          method: "get",
          path: "reports/coupons/totals",
          jsonResponse: (json) =>
              (json as List).map((i) => TotalReport.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/reports#retrieve-customers-totals
  Future<List<TotalReport>> getTotalCustomerReports() async {
    return await _wooSignalRequest<List<TotalReport>>(
          method: "get",
          path: "reports/customers/totals",
          jsonResponse: (json) =>
              (json as List).map((i) => TotalReport.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/reports#retrieve-orders-totals
  Future<List<TotalReport>> getTotalOrderReports() async {
    return await _wooSignalRequest<List<TotalReport>>(
          method: "get",
          path: "reports/orders/totals",
          jsonResponse: (json) =>
              (json as List).map((i) => TotalReport.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/reports#retrieve-products-totals
  Future<List<TotalReport>> getTotalProductReports() async {
    return await _wooSignalRequest<List<TotalReport>>(
          method: "get",
          path: "reports/products/totals",
          jsonResponse: (json) =>
              (json as List).map((i) => TotalReport.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/reports#retrieve-reviews-totals
  Future<List<TotalReport>> getTotalReviewReports() async {
    return await _wooSignalRequest<List<TotalReport>>(
          method: "get",
          path: "reports/reviews/totals",
          jsonResponse: (json) =>
              (json as List).map((i) => TotalReport.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/system-status
  Future<SystemStatus?> getSystemStatus() async {
    return await _wooSignalRequest<SystemStatus?>(
      method: "get",
      path: "system_status",
      jsonResponse: (json) => SystemStatus.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/setting-options#delete-an-order
  Future<ob.Orders?> deleteOrder(int id, {bool force = false}) async {
    Map<String, dynamic> payload = {'force': force};
    return await _wooSignalRequest<ob.Orders?>(
      method: "delete",
      path: "orders/$id",
      payload: payload,
      jsonResponse: (json) => ob.Orders.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/setting-options#batch-update-orders
  Future<ob.OrderBatch?> batchOrders(
      {required Map<String, dynamic> data}) async {
    return await _wooSignalRequest<ob.OrderBatch?>(
      method: "post",
      path: "orders/batch",
      payload: data,
      jsonResponse: (json) => ob.OrderBatch.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/setting-options#retrieve-a-setting-option
  Future<SettingOption?> retrieveSettingOptions(
      {required String groupId, required String id}) async {
    return await _wooSignalRequest<SettingOption?>(
      method: "get",
      path: "settings/${groupId.toString()}/${id.toString()}",
      jsonResponse: (json) => SettingOption.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/setting-options#list-all-setting-options
  Future<List<SettingOption>> getSettingOptions({String? groupId}) async {
    return await _wooSignalRequest<List<SettingOption>>(
          method: "get",
          path: "settings/${groupId.toString()}",
          jsonResponse: (json) =>
              (json as List).map((i) => SettingOption.fromJson(i)).toList(),
        ) ??
        [];
  }

  /// https://woosignal.com/docs/api/1.0/setting-options#update-a-setting-option
  Future<SettingOption?> updateSettingOptions(String groupId, String id,
      {required Map<String, dynamic> data}) async {
    return await _wooSignalRequest<SettingOption?>(
      method: "put",
      path: "settings/${groupId.toString()}/${id.toString()}",
      payload: data,
      jsonResponse: (json) => SettingOption.fromJson(json),
    );
  }

  //  Note: By default it's limited to up to 100 objects to be created, updated or deleted.
  /// https://woosignal.com/docs/api/1.0/setting-options#batch-update-setting-options
  Future<SettingOptionBatch?> batchSettingOptions(
      {required Map<String, dynamic> data}) async {
    return await _wooSignalRequest<SettingOptionBatch?>(
      method: "post",
      path: "settings/general/batch",
      payload: data,
      jsonResponse: (json) => SettingOptionBatch.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/products#create-a-product
  Future<Product?> createProduct({
    required String name,
    String type = "simple", // simple, grouped, external and variable.
    required String regularPrice,
    String? salePrice,
    String? description,
    String? shortDescription,
    String? catalogVisibility,
    String? sku,
    String? taxStatus,
    String? taxClass,
    bool? virtual,
    String? purchaseNote,
    String? stockStatus,
    bool? featured,
    bool? downloadable,
    int? stockQuantity,
    List<Map<String, dynamic>>? categories,
    List<Map<String, dynamic>>? images,
    List<Map<String, dynamic>>? metaData,
  }) async {
    Map<String, dynamic> payload = {};
    payload['name'] = name;
    payload['type'] = type;
    payload['regular_price'] = regularPrice;
    if (description != null) payload['description'] = description;
    if (shortDescription != null) {
      payload['short_description'] = shortDescription;
    }
    if (categories != null) payload['categories'] = categories;
    if (images != null) payload['images'] = images;
    if (metaData != null) payload['meta_data'] = metaData;
    if (featured != null) payload['featured'] = featured;
    if (catalogVisibility != null) {
      payload['catalog_visibility'] = catalogVisibility;
    }
    if (sku != null) payload['sku'] = sku;
    if (salePrice != null) payload['sale_price'] = salePrice;
    if (downloadable != null) payload['downloadable'] = downloadable;
    if (stockQuantity != null) payload['stock_quantity'] = stockQuantity;
    if (purchaseNote != null) payload['purchase_note'] = purchaseNote;
    if (stockStatus != null) payload['stock_status'] = stockStatus;
    if (virtual != null) payload['virtual'] = virtual;
    if (taxStatus != null) payload['tax_status'] = taxStatus;
    if (taxClass != null) payload['tax_class'] = taxClass;

    return await _wooSignalRequest<Product?>(
      method: "post",
      path: "products",
      payload: payload,
      jsonResponse: (json) => Product.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/products#update-a-product
  Future<Product?> updateProduct(int id,
      {required Map<String, dynamic> data}) async {
    return await _wooSignalRequest<Product?>(
      method: "put",
      path: "products/$id",
      payload: data,
      jsonResponse: (json) => Product.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/products#delete-a-product
  Future<Product?> deleteProduct(int id, {bool force = false}) async {
    Map<String, dynamic> payload = {'force': force};
    return await _wooSignalRequest<Product?>(
      method: "delete",
      path: "products/$id",
      payload: payload,
      jsonResponse: (json) => Product.fromJson(json),
    );
  }

  // Note: By default it's limited to up to 100 objects to be created, updated or deleted.
  /// https://woosignal.com/docs/api/1.0/products#batch-products
  Future<ProductBatch?> batchProduct(
      {required Map<String, dynamic> data}) async {
    return await _wooSignalRequest<ProductBatch?>(
      method: "post",
      path: "coupons/batch",
      payload: data,
      jsonResponse: (json) => ProductBatch.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/products#create-product-tags
  Future<ProductTag?> createProductTag(
      {required String name, String? slug, String? description}) async {
    Map<String, dynamic> payload = {'name': name};
    if (slug != null) payload['slug'] = slug;
    if (description != null) payload['description'] = description;

    return await _wooSignalRequest<ProductTag?>(
      method: "post",
      path: "products/tags",
      payload: payload,
      jsonResponse: (json) => ProductTag.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/products#create-product-tag
  Future<ProductTag?> retrieveProductTag(int id) async {
    return await _wooSignalRequest<ProductTag?>(
      method: "get",
      path: "products/tags/$id",
      jsonResponse: (json) => ProductTag.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/products#create-product-tags
  Future<List<ProductTag>?> getProductTags(
      {String? context,
      int? page,
      int? perPage,
      String? search,
      List<int>? exclude,
      List<int>? include,
      int? offset,
      String? order,
      String? orderBy,
      bool? hideEmpty,
      int? product,
      String? slug}) async {
    Map<String, dynamic> payload = {};

    if (context != null) payload["context"] = context;
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

    return await _wooSignalRequest<List<ProductTag>?>(
      method: "get",
      path: "products/tags",
      payload: payload,
      jsonResponse: (json) =>
          (json as List).map((i) => ProductTag.fromJson(i)).toList(),
    );
  }

  /// https://woosignal.com/docs/api/1.0/products#create-product-tags
  Future<ProductTag?> updateProductTag(int productTagId,
      {Map<String, dynamic>? data}) async {
    return await _wooSignalRequest<ProductTag?>(
      method: "put",
      path: "products/tags/$productTagId",
      payload: data ?? {},
      jsonResponse: (json) => ProductTag.fromJson(json),
    );
  }

  /// https://woosignal.com/docs/api/1.0/products#delete-product-tags
  Future<ProductTag?> deleteProductTag(int productTagId,
      {bool force = false}) async {
    Map<String, dynamic> payload = {"force": force};
    return await _wooSignalRequest<ProductTag?>(
      method: "delete",
      path: "products/tags/$productTagId",
      payload: payload,
      jsonResponse: (json) => ProductTag.fromJson(json),
    );
  }
}
