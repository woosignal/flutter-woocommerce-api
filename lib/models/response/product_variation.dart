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
import 'package:woosignal/models/response/dimension.dart';

import '../meta_data.dart';

class ProductVariation {
  int? id;
  DateTime? dateCreated;
  DateTime? dateCreatedGmt;
  DateTime? dateModified;
  DateTime? dateModifiedGmt;
  String? description;
  String? permalink;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  DateTime? dateOnSaleFrom;
  DateTime? dateOnSaleFromGmt;
  DateTime? dateOnSaleTo;
  DateTime? dateOnSaleToGmt;
  bool? onSale;
  String? status;
  bool? purchasable;
  bool? virtual;
  bool? downloadable;
  List<Download> downloads;
  int? downloadLimit;
  int? downloadExpiry;
  String? taxStatus;
  String? taxClass;
  bool? manageStock;
  int? stockQuantity;
  String? stockStatus;
  String? backorders;
  bool? backordersAllowed;
  bool? backOrdered;
  List<Attribute> attributes;
  String? weight;
  String? shippingClass;
  int? shippingClassId;
  int? menuOrder;
  Dimension dimensions;
  List<MetaData> metaData;
  Image? image;

  ProductVariation(
      this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.dateModified,
      this.dateModifiedGmt,
      this.description,
      this.permalink,
      this.sku,
      this.price,
      this.attributes,
      this.regularPrice,
      this.salePrice,
      this.dateOnSaleFrom,
      this.dateOnSaleFromGmt,
      this.dateOnSaleTo,
      this.dateOnSaleToGmt,
      this.onSale,
      this.status,
      this.purchasable,
      this.virtual,
      this.downloadable,
      this.downloads,
      this.downloadLimit,
      this.downloadExpiry,
      this.taxStatus,
      this.taxClass,
      this.manageStock,
      this.stockQuantity,
      this.stockStatus,
      this.backorders,
      this.backordersAllowed,
      this.backOrdered,
      this.weight,
      this.shippingClass,
      this.shippingClassId,
      this.menuOrder,
      this.dimensions,
      this.metaData,
      this.image);

  ProductVariation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        permalink = json['permalink'],
        status = json['status'],
        description = json['description'],
        sku = json['sku'],
        price = json['price'],
        regularPrice = json['regular_price'],
        salePrice = json['sale_price'],
        onSale = json['on_sale'],
        purchasable = json['purchasable'],
        virtual = json['virtual'],
        downloadable = json['downloadable'],
        downloads = (json['downloads'] as List)
            .map((i) => Download.fromJson(i))
            .toList(),
        downloadLimit = json['download_limit'],
        downloadExpiry = json['download_expiry'],
        taxStatus = json['tax_status'],
        taxClass = json['tax_class'],
        manageStock =
            (json['manage_stock'] != null && json['manage_stock'] is bool)
                ? json['manage_stock']
                : false,
        stockQuantity = json['stock_quantity'],
        stockStatus = json['stock_status'],
        backorders = json['backorders'],
        backordersAllowed = json['backorders_allowed'],
        backOrdered = json['backordered'],
        weight = json['weight'],
        dimensions = Dimension.fromJson(json['dimensions']),
        shippingClass = json['shipping_class'],
        shippingClassId = json['shipping_class_id'],
        menuOrder = json['menu_order'],
        attributes = (json['attributes'] as List)
            .map((i) => Attribute.fromJson(i))
            .toList(),
        metaData = (json['meta_data'] as List)
            .map((i) => MetaData.fromJson(i))
            .toList();
}

class Category {
  final int? id;
  final String? name;
  final String? slug;

  Category(this.id, this.name, this.slug);

  Category.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        slug = json['slug'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
      };
}

class Attribute {
  final int? id;
  final String? name;
  final String? option;

  Attribute(this.id, this.name, this.option);

  Attribute.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        option = json['option'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'option': option,
      };
}

class Download {
  final String? id;
  final String? name;
  final String? file;

  Download(this.id, this.name, this.file);

  Download.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        file = json['file'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'file': file,
      };
}
