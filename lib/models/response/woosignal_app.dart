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

class WooSignalApp {
  String? appName;
  String? appLogo;
  String? appTermslink;
  String? appPrivacylink;
  int? appDebug;
  int? appStatus;
  CurrencyMeta? currencyMeta;
  List<String>? bannerImages;
  bool? stripeLiveMode;
  String? stripeAccount;
  int? wpLoginEnabled;
  String? wpLoginBaseUrl;
  String? wpLoginForgotPasswordUrl;
  String? wpLoginWpApiPath;
  int? productPricesIncludeTax;
  int? disableShipping;
  String? theme;

  WooSignalApp(
      {this.appName,
      this.appLogo,
      this.appTermslink,
      this.appPrivacylink,
      this.appDebug,
      this.appStatus,
      this.currencyMeta,
      this.bannerImages,
      this.stripeLiveMode,
      this.stripeAccount,
      this.wpLoginEnabled,
      this.wpLoginBaseUrl,
      this.wpLoginForgotPasswordUrl,
      this.wpLoginWpApiPath,
      this.productPricesIncludeTax,
      this.disableShipping,
      this.theme});

  WooSignalApp.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    appLogo = json['app_logo'];
    appTermslink = json['app_termslink'];
    appPrivacylink = json['app_privacylink'];
    appDebug = json['app_debug'];
    appStatus = json['app_status'];
    currencyMeta = json['currency_meta'] != null
        ? new CurrencyMeta.fromJson(json['currency_meta'])
        : null;
    bannerImages = json['banner_images'].cast<String>();
    stripeLiveMode = json['stripe_live_mode'];
    stripeAccount = json['stripe_account'];
    wpLoginEnabled = json['wp_login_enabled'];
    wpLoginBaseUrl = json['wp_login_base_url'];
    wpLoginForgotPasswordUrl = json['wp_login_forgot_password_url'];
    wpLoginWpApiPath = json['wp_login_wp_api_path'];
    productPricesIncludeTax = json['product_prices_include_tax'];
    disableShipping = json['disable_shipping'];
    theme = json['theme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['app_name'] = this.appName;
    data['app_logo'] = this.appLogo;
    data['app_termslink'] = this.appTermslink;
    data['app_privacylink'] = this.appPrivacylink;
    data['app_debug'] = this.appDebug;
    data['app_status'] = this.appStatus;
    if (this.currencyMeta != null) {
      data['currency_meta'] = this.currencyMeta!.toJson();
    }
    data['banner_images'] = this.bannerImages;
    data['stripe_live_mode'] = this.stripeLiveMode;
    data['stripe_account'] = this.stripeAccount;
    data['wp_login_enabled'] = this.wpLoginEnabled;
    data['wp_login_base_url'] = this.wpLoginBaseUrl;
    data['wp_login_forgot_password_url'] = this.wpLoginForgotPasswordUrl;
    data['wp_login_wp_api_path'] = this.wpLoginWpApiPath;
    data['product_prices_include_tax'] = this.productPricesIncludeTax;
    data['disable_shipping'] = this.disableShipping;
    data['theme'] = this.theme;
    return data;
  }
}

class CurrencyMeta {
  String? symbol;
  String? name;
  String? symbolNative;
  int? decimalDigits;
  int? rounding;
  String? code;
  String? namePlural;

  CurrencyMeta(
      {this.symbol,
      this.name,
      this.symbolNative,
      this.decimalDigits,
      this.rounding,
      this.code,
      this.namePlural});

  CurrencyMeta.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    name = json['name'];
    symbolNative = json['symbol_native'];
    decimalDigits = json['decimal_digits'];
    rounding = json['rounding'];
    code = json['code'];
    namePlural = json['name_plural'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['name'] = this.name;
    data['symbol_native'] = this.symbolNative;
    data['decimal_digits'] = this.decimalDigits;
    data['rounding'] = this.rounding;
    data['code'] = this.code;
    data['name_plural'] = this.namePlural;
    return data;
  }
}
