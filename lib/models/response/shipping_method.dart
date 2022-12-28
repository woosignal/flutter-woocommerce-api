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

class WSShipping {
  int? parentId;
  String? name;
  List<Locations>? locations;
  Methods? methods;

  WSShipping({this.parentId, this.name, this.locations, this.methods});

  WSShipping.fromJson(Map<String, dynamic> json) {
    parentId = json['parent_id'];
    name = json['name'];
    if (json['locations'] != null) {
      locations = [];
      json['locations'].forEach((v) {
        locations!.add(Locations.fromJson(v));
      });
    }
    methods =
        json['methods'] != null ? Methods.fromJson(json['methods']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['parent_id'] = parentId;
    data['name'] = name;
    if (locations != null) {
      data['locations'] = locations!.map((v) => v.toJson()).toList();
    }
    if (methods != null) {
      data['methods'] = methods!.toJson();
    }
    return data;
  }
}

class Locations {
  String? code;
  String? type;

  Locations({this.code, this.type});

  Locations.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['type'] = type;
    return data;
  }
}

class Methods {
  List<FreeShipping>? freeShipping;
  List<FlatRate>? flatRate;
  List<LocalPickup>? localPickup;

  Methods({this.freeShipping, this.flatRate, this.localPickup});

  Methods.fromJson(Map<String, dynamic> json) {
    if (json['free_shipping'] != null) {
      freeShipping = [];
      json['free_shipping'].forEach((v) {
        freeShipping!.add(FreeShipping.fromJson(v));
      });
    }
    if (json['flat_rate'] != null) {
      flatRate = [];
      json['flat_rate'].forEach((v) {
        flatRate!.add(FlatRate.fromJson(v));
      });
    }
    if (json['local_pickup'] != null) {
      localPickup = [];
      json['local_pickup'].forEach((v) {
        localPickup!.add(LocalPickup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (freeShipping != null) {
      data['free_shipping'] = freeShipping!.map((v) => v.toJson()).toList();
    }
    if (flatRate != null) {
      data['flat_rate'] = flatRate!.map((v) => v.toJson()).toList();
    }
    if (localPickup != null) {
      data['local_pickup'] = localPickup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FreeShipping {
  int? id;
  String? title;
  String? methodId;
  String? cost;
  String? minimumOrderAmount;

  FreeShipping(
      {this.id, this.title, this.methodId, this.cost, this.minimumOrderAmount});

  FreeShipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    methodId = json['method_id'];
    cost = json['cost'];
    if (json['cost'] != null && json['cost'] == 'min_amount') {
      minimumOrderAmount = json['kind']['min_amount'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['method_id'] = methodId;
    data['cost'] = cost;
    if (minimumOrderAmount != null) {
      data['minimum_order_amount'] = minimumOrderAmount;
    }
    return data;
  }
}

class FlatRate {
  int? id;
  String? title;
  String? methodId;
  String? cost;
  String? classCost;
  String? calculationType;
  bool? taxable;
  List<ShippingClasses>? shippingClasses;

  FlatRate(
      {this.id,
      this.title,
      this.methodId,
      this.cost,
      this.classCost,
      this.calculationType,
      this.taxable,
      this.shippingClasses});

  FlatRate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    methodId = json['method_id'];
    cost = json['cost'];
    classCost = json['class_cost'];
    calculationType = json['calculation_type'];
    taxable = json['taxable'];
    if (json['shipping_classes'] != null) {
      shippingClasses = [];
      json['shipping_classes'].forEach((v) {
        shippingClasses!.add(ShippingClasses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['method_id'] = methodId;
    data['cost'] = cost;
    data['class_cost'] = classCost;
    data['calculation_type'] = calculationType;
    data['taxable'] = taxable;
    if (shippingClasses != null) {
      data['shipping_classes'] =
          shippingClasses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingClasses {
  String? id;
  String? cost;

  ShippingClasses({this.id, this.cost});

  ShippingClasses.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cost'] = cost;
    return data;
  }
}

class LocalPickup {
  int? id;
  String? title;
  String? methodId;
  bool? taxable;
  String? cost;

  LocalPickup({this.id, this.title, this.methodId, this.taxable, this.cost});

  LocalPickup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    methodId = json['method_id'];
    taxable = json['taxable'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['method_id'] = methodId;
    data['taxable'] = taxable;
    data['cost'] = cost;
    return data;
  }
}
