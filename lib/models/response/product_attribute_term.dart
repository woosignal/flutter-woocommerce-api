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

class ProductAttributeTerm {
  int? id;
  String? name;
  String? slug;
  String? description;
  int? menuOrder;
  int? count;
  Links? links;

  ProductAttributeTerm(
      {this.id,
      this.name,
      this.slug,
      this.description,
      this.menuOrder,
      this.count,
      this.links});

  ProductAttributeTerm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slug = json['slug'];
    description = json['description'];
    menuOrder = json['menu_order'];
    count = json['count'];
    links = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['slug'] = this.slug;
    data['description'] = this.description;
    data['menu_order'] = this.menuOrder;
    data['count'] = this.count;
    if (this.links != null) {
      data['_links'] = this.links!.toJson();
    }
    return data;
  }
}
