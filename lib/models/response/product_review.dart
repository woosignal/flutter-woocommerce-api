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

class ProductReview {
  int? id;
  String? dateCreated;
  String? dateCreatedGmt;
  int? productId;
  String? status;
  String? reviewer;
  String? reviewerEmail;
  String? review;
  int? rating;
  bool? verified;
  Map<String, dynamic>? reviewerAvatarUrls;
  Links? links;

  ProductReview(
      {this.id,
      this.dateCreated,
      this.dateCreatedGmt,
      this.productId,
      this.status,
      this.reviewer,
      this.reviewerEmail,
      this.review,
      this.rating,
      this.verified,
      this.reviewerAvatarUrls,
      this.links});

  ProductReview.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dateCreated = json['date_created'];
    dateCreatedGmt = json['date_created_gmt'];
    productId = json['product_id'];
    status = json['status'];
    reviewer = json['reviewer'];
    reviewerEmail = json['reviewer_email'];
    review = json['review'];
    rating = json['rating'];
    verified = json['verified'];
    reviewerAvatarUrls = json['reviewer_avatar_urls'] != null
        ? (json['reviewer_avatar_urls'])
        : null;
    links = json['_links'] != null ? new Links.fromJson(json['_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date_created'] = this.dateCreated;
    data['date_created_gmt'] = this.dateCreatedGmt;
    data['product_id'] = this.productId;
    data['status'] = this.status;
    data['reviewer'] = this.reviewer;
    data['reviewer_email'] = this.reviewerEmail;
    data['review'] = this.review;
    data['rating'] = this.rating;
    data['verified'] = this.verified;
    if (this.reviewerAvatarUrls != null) {
      data['reviewer_avatar_urls'] = this.reviewerAvatarUrls.toString();
    }
    if (this.links != null) {
      data['_links'] = this.links!.toJson();
    }
    return data;
  }
}
