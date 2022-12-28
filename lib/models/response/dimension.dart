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

class Dimension {
  final String? length;
  final String? width;
  final String? height;

  Dimension(this.length, this.height, this.width);

  Dimension.fromJson(Map<String, dynamic> json)
      : length =
            json['length'] is int ? json['length'].toString() : json['length'],
        width = json['width'] is int ? json['width'].toString() : json['width'],
        height =
            json['height'] is int ? json['height'].toString() : json['height'];

  Map<String, dynamic> toJson() =>
      {'length': length, 'width': width, 'height': height};
}
