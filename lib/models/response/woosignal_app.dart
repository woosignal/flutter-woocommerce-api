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
  String? appTermsLink;
  String? appPrivacyLink;
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
  String? locale;
  String? paypalLocale;
  String? paypalEmail;
  bool? stripeEnabled;
  bool? codEnabled;
  bool? paypalEnabled;
  bool? paypalLiveMode;
  String? stripeCountryCode;
  String? themeFont;
  Map<String, dynamic>? socialLinks;
  Map<String, dynamic>? themeColors;

  WooSignalApp(
      {this.appName,
      this.appLogo,
      this.appTermsLink,
      this.appPrivacyLink,
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
      this.theme,
      this.locale,
      this.paypalLocale,
      this.paypalEmail,
      this.stripeEnabled,
      this.codEnabled,
      this.paypalEnabled,
      this.paypalLiveMode,
      this.stripeCountryCode,
      this.themeFont,
      this.socialLinks,
      this.themeColors});

  WooSignalApp.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    appLogo = json['app_logo'];
    appTermsLink = json['app_termslink'];
    appPrivacyLink = json['app_privacylink'];
    appDebug = json['app_debug'];
    appStatus = json['app_status'];
    currencyMeta = json['currency_meta'] != null
        ? CurrencyMeta.fromJson(json['currency_meta'])
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
    locale = json['locale'];
    paypalLocale = json['paypal_locale'] ?? "en-GB";
    paypalEmail = json['paypal_email'] ?? "";
    stripeEnabled = (json['stripe_enabled'] ?? 0) == 1 ? true : false;
    codEnabled = (json['cod_enabled'] ?? 0) == 1 ? true : false;
    paypalEnabled = (json['paypal_enabled'] ?? 0) == 1 ? true : false;
    paypalLiveMode = (json['paypal_live_mode'] ?? 0) == 1 ? true : false;
    stripeCountryCode = json['stripe_country_code'] ?? "GB";
    if (json.containsKey('theme_font') && json['theme_font'] != null) {
      themeFont = json['theme_font'];
    }
    if (json.containsKey('social_links') && json['social_links'] is Map<String, dynamic>?) {
      socialLinks = json['social_links'];
    }
    if (json.containsKey('theme_colors') && json['theme_colors'] is Map<String, dynamic>?) {
      themeColors = json['theme_colors'];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['app_logo'] = appLogo;
    data['app_termslink'] = appTermsLink;
    data['app_privacylink'] = appPrivacyLink;
    data['app_debug'] = appDebug;
    data['app_status'] = appStatus;
    if (currencyMeta != null) {
      data['currency_meta'] = currencyMeta!.toJson();
    }
    data['banner_images'] = bannerImages;
    data['stripe_live_mode'] = stripeLiveMode;
    data['stripe_account'] = stripeAccount;
    data['wp_login_enabled'] = wpLoginEnabled;
    data['wp_login_base_url'] = wpLoginBaseUrl;
    data['wp_login_forgot_password_url'] = wpLoginForgotPasswordUrl;
    data['wp_login_wp_api_path'] = wpLoginWpApiPath;
    data['product_prices_include_tax'] = productPricesIncludeTax;
    data['disable_shipping'] = disableShipping;
    data['theme'] = theme;
    data['locale'] = locale;
    data['paypal_locale'] = paypalLocale;
    data['paypal_email'] = paypalEmail;
    data['stripe_enabled'] = stripeEnabled;
    data['cod_enabled'] = codEnabled;
    data['paypal_enabled'] = paypalEnabled;
    data['stripe_country_code'] = stripeCountryCode;
    data['theme_font'] = themeFont;
    data['social_links'] = socialLinks;
    data['theme_colors'] = themeColors;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symbol'] = symbol;
    data['name'] = name;
    data['symbol_native'] = symbolNative;
    data['decimal_digits'] = decimalDigits;
    data['rounding'] = rounding;
    data['code'] = code;
    data['name_plural'] = namePlural;
    return data;
  }
}
