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

class TaxRate {
  int? id;
  String? country;
  String? state;
  String? postcode;
  String? city;
  String? rate;
  String? name;
  int? priority;
  bool? compound;
  bool? shipping;
  int? order;
  String? taxClass;
  Links? links;

  TaxRate(
      {this.id,
      this.country,
      this.state,
      this.postcode,
      this.city,
      this.rate,
      this.name,
      this.priority,
      this.compound,
      this.shipping,
      this.order,
      this.taxClass,
      this.links});

  TaxRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    country = json['country'];
    state = json['state'];
    postcode = json['postcode'];
    city = json['city'];
    rate = json['rate'];
    name = json['name'];
    priority = json['priority'];
    compound = json['compound'];
    shipping = json['shipping'];
    order = json['order'];
    taxClass = json['class'];
    links = json['_links'] != null ? Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country'] = country;
    data['state'] = state;
    data['postcode'] = postcode;
    data['city'] = city;
    data['rate'] = rate;
    data['name'] = name;
    data['priority'] = priority;
    data['compound'] = compound;
    data['shipping'] = shipping;
    data['order'] = order;
    data['class'] = taxClass;
    if (links != null) {
      data['_links'] = links!.toJson();
    }
    return data;
  }
}
