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

import 'package:woosignal/models/links.dart';
import 'package:woosignal/models/response/shipping_method.dart';

List<PaymentGateWay> paymentGateWayFromJson(String str) =>
    List<PaymentGateWay>.from(
        json.decode(str).map((x) => PaymentGateWay.fromJson(x)));

String paymentGateWayToJson(List<PaymentGateWay> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentGateWay {
  PaymentGateWay({
    this.id,
    this.title,
    this.description,
    this.order,
    this.enabled,
    this.methodTitle,
    this.methodDescription,
    this.methodSupports,
    this.settings,
    this.links,
  });

  String? id;
  String? title;
  String? description;
  String? order;
  bool? enabled;
  String? methodTitle;
  String? methodDescription;
  List<String>? methodSupports;
  Settings? settings;
  Links? links;

  factory PaymentGateWay.fromJson(Map<String, dynamic> json) => PaymentGateWay(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        order: json["order"],
        enabled: json["enabled"],
        methodTitle: json["method_title"],
        methodDescription: json["method_description"],
        methodSupports:
            List<String>.from(json["method_supports"].map((x) => x)),
        settings: Settings.fromJson(json["settings"]),
        links: Links.fromJson(json["_links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "order": order,
        "enabled": enabled,
        "method_title": methodTitle,
        "method_description": methodDescription,
        "method_supports": List<dynamic>.from(methodSupports!.map((x) => x)),
        "settings": settings!.toJson(),
        "_links": links!.toJson(),
      };
}

class Settings {
  Settings({
    this.title,
    this.instructions,
    this.enableForMethods,
    this.enableForVirtual,
    this.email,
    this.advanced,
    this.testmode,
    this.debug,
    this.ipnNotification,
    this.receiverEmail,
    this.identityToken,
    this.invoicePrefix,
    this.sendShipping,
    this.addressOverride,
    this.paymentaction,
    this.pageStyle,
    this.imageUrl,
    this.apiDetails,
    this.apiUsername,
    this.apiPassword,
    this.apiSignature,
    this.sandboxApiUsername,
    this.sandboxApiPassword,
    this.sandboxApiSignature,
    this.accountSettings,
    this.environment,
    this.apiCredentials,
    this.apiCertificate,
    this.apiSubject,
    this.sandboxApiCredentials,
    this.sandboxApiCertificate,
    this.sandboxApiSubject,
    this.paypalHostedSettings,
    this.brandName,
    this.logoImageUrl,
    this.headerImageUrl,
    this.landingPage,
    this.requireBilling,
    this.requirePhoneNumber,
    this.instantPayments,
    this.subtotalMismatchBehavior,
    this.buttonSettings,
    this.useSpb,
    this.buttonColor,
    this.buttonShape,
    this.buttonLayout,
    this.buttonSize,
    this.hideFundingMethods,
    this.creditEnabled,
    this.cartCheckoutEnabled,
    this.miniCartSettings,
    this.miniCartSettingsToggle,
    this.miniCartButtonLayout,
    this.miniCartButtonSize,
    this.miniCartHideFundingMethods,
    this.miniCartCreditEnabled,
    this.singleProductSettings,
    this.checkoutOnSingleProductEnabled,
    this.singleProductSettingsToggle,
    this.singleProductButtonLayout,
    this.singleProductButtonSize,
    this.singleProductHideFundingMethods,
    this.singleProductCreditEnabled,
    this.markSettings,
    this.markEnabled,
    this.markSettingsToggle,
    this.markButtonLayout,
    this.markButtonSize,
    this.markHideFundingMethods,
    this.markCreditEnabled,
    this.webhook,
    this.testPublishableKey,
    this.testSecretKey,
    this.testWebhookSecret,
    this.publishableKey,
    this.secretKey,
    this.webhookSecret,
    this.inlineCcForm,
    this.statementDescriptor,
    this.capture,
    this.paymentRequest,
    this.paymentRequestButtonType,
    this.paymentRequestButtonTheme,
    this.paymentRequestButtonHeight,
    this.savedCards,
    this.logging,
  });

  Title? title;
  Title? instructions;
  Title? enableForMethods;
  Title? enableForVirtual;
  Title? email;
  Title? advanced;
  Title? testmode;
  Title? debug;
  Title? ipnNotification;
  Title? receiverEmail;
  Title? identityToken;
  Title? invoicePrefix;
  Title? sendShipping;
  Title? addressOverride;
  Title? paymentaction;
  Title? pageStyle;
  Title? imageUrl;
  Title? apiDetails;
  Title? apiUsername;
  Title? apiPassword;
  Title? apiSignature;
  Title? sandboxApiUsername;
  Title? sandboxApiPassword;
  Title? sandboxApiSignature;
  Title? accountSettings;
  Title? environment;
  Title? apiCredentials;
  Title? apiCertificate;
  Title? apiSubject;
  Title? sandboxApiCredentials;
  Title? sandboxApiCertificate;
  Title? sandboxApiSubject;
  Title? paypalHostedSettings;
  Title? brandName;
  Title? logoImageUrl;
  Title? headerImageUrl;
  Title? landingPage;
  Title? requireBilling;
  Title? requirePhoneNumber;
  Title? instantPayments;
  Title? subtotalMismatchBehavior;
  Title? buttonSettings;
  Title? useSpb;
  Title? buttonColor;
  Title? buttonShape;
  Title? buttonLayout;
  Title? buttonSize;
  HideFundingMethods? hideFundingMethods;
  Title? creditEnabled;
  Title? cartCheckoutEnabled;
  Title? miniCartSettings;
  Title? miniCartSettingsToggle;
  Title? miniCartButtonLayout;
  Title? miniCartButtonSize;
  HideFundingMethods? miniCartHideFundingMethods;
  Title? miniCartCreditEnabled;
  Title? singleProductSettings;
  Title? checkoutOnSingleProductEnabled;
  Title? singleProductSettingsToggle;
  Title? singleProductButtonLayout;
  Title? singleProductButtonSize;
  HideFundingMethods? singleProductHideFundingMethods;
  Title? singleProductCreditEnabled;
  Title? markSettings;
  Title? markEnabled;
  Title? markSettingsToggle;
  Title? markButtonLayout;
  Title? markButtonSize;
  HideFundingMethods? markHideFundingMethods;
  Title? markCreditEnabled;
  Title? webhook;
  Title? testPublishableKey;
  Title? testSecretKey;
  Title? testWebhookSecret;
  Title? publishableKey;
  Title? secretKey;
  Title? webhookSecret;
  Title? inlineCcForm;
  Title? statementDescriptor;
  Title? capture;
  Title? paymentRequest;
  Title? paymentRequestButtonType;
  Title? paymentRequestButtonTheme;
  Title? paymentRequestButtonHeight;
  Title? savedCards;
  Title? logging;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        title: Title.fromJson(json["title"]),
        instructions: json["instructions"] == null
            ? null
            : Title.fromJson(json["instructions"]),
        enableForMethods: json["enable_for_methods"] == null
            ? null
            : Title.fromJson(json["enable_for_methods"]),
        enableForVirtual: json["enable_for_virtual"] == null
            ? null
            : Title.fromJson(json["enable_for_virtual"]),
        email: json["email"] == null ? null : Title.fromJson(json["email"]),
        advanced:
            json["advanced"] == null ? null : Title.fromJson(json["advanced"]),
        testmode:
            json["testmode"] == null ? null : Title.fromJson(json["testmode"]),
        debug: json["debug"] == null ? null : Title.fromJson(json["debug"]),
        ipnNotification: json["ipn_notification"] == null
            ? null
            : Title.fromJson(json["ipn_notification"]),
        receiverEmail: json["receiver_email"] == null
            ? null
            : Title.fromJson(json["receiver_email"]),
        identityToken: json["identity_token"] == null
            ? null
            : Title.fromJson(json["identity_token"]),
        invoicePrefix: json["invoice_prefix"] == null
            ? null
            : Title.fromJson(json["invoice_prefix"]),
        sendShipping: json["send_shipping"] == null
            ? null
            : Title.fromJson(json["send_shipping"]),
        addressOverride: json["address_override"] == null
            ? null
            : Title.fromJson(json["address_override"]),
        paymentaction: json["paymentaction"] == null
            ? null
            : Title.fromJson(json["paymentaction"]),
        pageStyle: json["page_style"] == null
            ? null
            : Title.fromJson(json["page_style"]),
        imageUrl: json["image_url"] == null
            ? null
            : Title.fromJson(json["image_url"]),
        apiDetails: json["api_details"] == null
            ? null
            : Title.fromJson(json["api_details"]),
        apiUsername: json["api_username"] == null
            ? null
            : Title.fromJson(json["api_username"]),
        apiPassword: json["api_password"] == null
            ? null
            : Title.fromJson(json["api_password"]),
        apiSignature: json["api_signature"] == null
            ? null
            : Title.fromJson(json["api_signature"]),
        sandboxApiUsername: json["sandbox_api_username"] == null
            ? null
            : Title.fromJson(json["sandbox_api_username"]),
        sandboxApiPassword: json["sandbox_api_password"] == null
            ? null
            : Title.fromJson(json["sandbox_api_password"]),
        sandboxApiSignature: json["sandbox_api_signature"] == null
            ? null
            : Title.fromJson(json["sandbox_api_signature"]),
        accountSettings: json["account_settings"] == null
            ? null
            : Title.fromJson(json["account_settings"]),
        environment: json["environment"] == null
            ? null
            : Title.fromJson(json["environment"]),
        apiCredentials: json["api_credentials"] == null
            ? null
            : Title.fromJson(json["api_credentials"]),
        apiCertificate: json["api_certificate"] == null
            ? null
            : Title.fromJson(json["api_certificate"]),
        apiSubject: json["api_subject"] == null
            ? null
            : Title.fromJson(json["api_subject"]),
        sandboxApiCredentials: json["sandbox_api_credentials"] == null
            ? null
            : Title.fromJson(json["sandbox_api_credentials"]),
        sandboxApiCertificate: json["sandbox_api_certificate"] == null
            ? null
            : Title.fromJson(json["sandbox_api_certificate"]),
        sandboxApiSubject: json["sandbox_api_subject"] == null
            ? null
            : Title.fromJson(json["sandbox_api_subject"]),
        paypalHostedSettings: json["paypal_hosted_settings"] == null
            ? null
            : Title.fromJson(json["paypal_hosted_settings"]),
        brandName: json["brand_name"] == null
            ? null
            : Title.fromJson(json["brand_name"]),
        logoImageUrl: json["logo_image_url"] == null
            ? null
            : Title.fromJson(json["logo_image_url"]),
        headerImageUrl: json["header_image_url"] == null
            ? null
            : Title.fromJson(json["header_image_url"]),
        landingPage: json["landing_page"] == null
            ? null
            : Title.fromJson(json["landing_page"]),
        requireBilling: json["require_billing"] == null
            ? null
            : Title.fromJson(json["require_billing"]),
        requirePhoneNumber: json["require_phone_number"] == null
            ? null
            : Title.fromJson(json["require_phone_number"]),
        instantPayments: json["instant_payments"] == null
            ? null
            : Title.fromJson(json["instant_payments"]),
        subtotalMismatchBehavior: json["subtotal_mismatch_behavior"] == null
            ? null
            : Title.fromJson(json["subtotal_mismatch_behavior"]),
        buttonSettings: json["button_settings"] == null
            ? null
            : Title.fromJson(json["button_settings"]),
        useSpb:
            json["use_spb"] == null ? null : Title.fromJson(json["use_spb"]),
        buttonColor: json["button_color"] == null
            ? null
            : Title.fromJson(json["button_color"]),
        buttonShape: json["button_shape"] == null
            ? null
            : Title.fromJson(json["button_shape"]),
        buttonLayout: json["button_layout"] == null
            ? null
            : Title.fromJson(json["button_layout"]),
        buttonSize: json["button_size"] == null
            ? null
            : Title.fromJson(json["button_size"]),
        hideFundingMethods: json["hide_funding_methods"] == null
            ? null
            : HideFundingMethods.fromJson(json["hide_funding_methods"]),
        creditEnabled: json["credit_enabled"] == null
            ? null
            : Title.fromJson(json["credit_enabled"]),
        cartCheckoutEnabled: json["cart_checkout_enabled"] == null
            ? null
            : Title.fromJson(json["cart_checkout_enabled"]),
        miniCartSettings: json["mini_cart_settings"] == null
            ? null
            : Title.fromJson(json["mini_cart_settings"]),
        miniCartSettingsToggle: json["mini_cart_settings_toggle"] == null
            ? null
            : Title.fromJson(json["mini_cart_settings_toggle"]),
        miniCartButtonLayout: json["mini_cart_button_layout"] == null
            ? null
            : Title.fromJson(json["mini_cart_button_layout"]),
        miniCartButtonSize: json["mini_cart_button_size"] == null
            ? null
            : Title.fromJson(json["mini_cart_button_size"]),
        miniCartHideFundingMethods:
            json["mini_cart_hide_funding_methods"] == null
                ? null
                : HideFundingMethods.fromJson(
                    json["mini_cart_hide_funding_methods"]),
        miniCartCreditEnabled: json["mini_cart_credit_enabled"] == null
            ? null
            : Title.fromJson(json["mini_cart_credit_enabled"]),
        singleProductSettings: json["single_product_settings"] == null
            ? null
            : Title.fromJson(json["single_product_settings"]),
        checkoutOnSingleProductEnabled:
            json["checkout_on_single_product_enabled"] == null
                ? null
                : Title.fromJson(json["checkout_on_single_product_enabled"]),
        singleProductSettingsToggle:
            json["single_product_settings_toggle"] == null
                ? null
                : Title.fromJson(json["single_product_settings_toggle"]),
        singleProductButtonLayout: json["single_product_button_layout"] == null
            ? null
            : Title.fromJson(json["single_product_button_layout"]),
        singleProductButtonSize: json["single_product_button_size"] == null
            ? null
            : Title.fromJson(json["single_product_button_size"]),
        singleProductHideFundingMethods:
            json["single_product_hide_funding_methods"] == null
                ? null
                : HideFundingMethods.fromJson(
                    json["single_product_hide_funding_methods"]),
        singleProductCreditEnabled:
            json["single_product_credit_enabled"] == null
                ? null
                : Title.fromJson(json["single_product_credit_enabled"]),
        markSettings: json["mark_settings"] == null
            ? null
            : Title.fromJson(json["mark_settings"]),
        markEnabled: json["mark_enabled"] == null
            ? null
            : Title.fromJson(json["mark_enabled"]),
        markSettingsToggle: json["mark_settings_toggle"] == null
            ? null
            : Title.fromJson(json["mark_settings_toggle"]),
        markButtonLayout: json["mark_button_layout"] == null
            ? null
            : Title.fromJson(json["mark_button_layout"]),
        markButtonSize: json["mark_button_size"] == null
            ? null
            : Title.fromJson(json["mark_button_size"]),
        markHideFundingMethods: json["mark_hide_funding_methods"] == null
            ? null
            : HideFundingMethods.fromJson(json["mark_hide_funding_methods"]),
        markCreditEnabled: json["mark_credit_enabled"] == null
            ? null
            : Title.fromJson(json["mark_credit_enabled"]),
        webhook:
            json["webhook"] == null ? null : Title.fromJson(json["webhook"]),
        testPublishableKey: json["test_publishable_key"] == null
            ? null
            : Title.fromJson(json["test_publishable_key"]),
        testSecretKey: json["test_secret_key"] == null
            ? null
            : Title.fromJson(json["test_secret_key"]),
        testWebhookSecret: json["test_webhook_secret"] == null
            ? null
            : Title.fromJson(json["test_webhook_secret"]),
        publishableKey: json["publishable_key"] == null
            ? null
            : Title.fromJson(json["publishable_key"]),
        secretKey: json["secret_key"] == null
            ? null
            : Title.fromJson(json["secret_key"]),
        webhookSecret: json["webhook_secret"] == null
            ? null
            : Title.fromJson(json["webhook_secret"]),
        inlineCcForm: json["inline_cc_form"] == null
            ? null
            : Title.fromJson(json["inline_cc_form"]),
        statementDescriptor: json["statement_descriptor"] == null
            ? null
            : Title.fromJson(json["statement_descriptor"]),
        capture:
            json["capture"] == null ? null : Title.fromJson(json["capture"]),
        paymentRequest: json["payment_request"] == null
            ? null
            : Title.fromJson(json["payment_request"]),
        paymentRequestButtonType: json["payment_request_button_type"] == null
            ? null
            : Title.fromJson(json["payment_request_button_type"]),
        paymentRequestButtonTheme: json["payment_request_button_theme"] == null
            ? null
            : Title.fromJson(json["payment_request_button_theme"]),
        paymentRequestButtonHeight:
            json["payment_request_button_height"] == null
                ? null
                : Title.fromJson(json["payment_request_button_height"]),
        savedCards: json["saved_cards"] == null
            ? null
            : Title.fromJson(json["saved_cards"]),
        logging:
            json["logging"] == null ? null : Title.fromJson(json["logging"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title!.toJson(),
        "instructions": instructions == null ? null : instructions!.toJson(),
        "enable_for_methods":
            enableForMethods == null ? null : enableForMethods!.toJson(),
        "enable_for_virtual":
            enableForVirtual == null ? null : enableForVirtual!.toJson(),
        "email": email == null ? null : email!.toJson(),
        "advanced": advanced == null ? null : advanced!.toJson(),
        "testmode": testmode == null ? null : testmode!.toJson(),
        "debug": debug == null ? null : debug!.toJson(),
        "ipn_notification":
            ipnNotification == null ? null : ipnNotification!.toJson(),
        "receiver_email":
            receiverEmail == null ? null : receiverEmail!.toJson(),
        "identity_token":
            identityToken == null ? null : identityToken!.toJson(),
        "invoice_prefix":
            invoicePrefix == null ? null : invoicePrefix!.toJson(),
        "send_shipping": sendShipping == null ? null : sendShipping!.toJson(),
        "address_override":
            addressOverride == null ? null : addressOverride!.toJson(),
        "paymentaction": paymentaction == null ? null : paymentaction!.toJson(),
        "page_style": pageStyle == null ? null : pageStyle!.toJson(),
        "image_url": imageUrl == null ? null : imageUrl!.toJson(),
        "api_details": apiDetails == null ? null : apiDetails!.toJson(),
        "api_username": apiUsername == null ? null : apiUsername!.toJson(),
        "api_password": apiPassword == null ? null : apiPassword!.toJson(),
        "api_signature": apiSignature == null ? null : apiSignature!.toJson(),
        "sandbox_api_username":
            sandboxApiUsername == null ? null : sandboxApiUsername!.toJson(),
        "sandbox_api_password":
            sandboxApiPassword == null ? null : sandboxApiPassword!.toJson(),
        "sandbox_api_signature":
            sandboxApiSignature == null ? null : sandboxApiSignature!.toJson(),
        "account_settings":
            accountSettings == null ? null : accountSettings!.toJson(),
        "environment": environment == null ? null : environment!.toJson(),
        "api_credentials":
            apiCredentials == null ? null : apiCredentials!.toJson(),
        "api_certificate":
            apiCertificate == null ? null : apiCertificate!.toJson(),
        "api_subject": apiSubject == null ? null : apiSubject!.toJson(),
        "sandbox_api_credentials": sandboxApiCredentials == null
            ? null
            : sandboxApiCredentials!.toJson(),
        "sandbox_api_certificate": sandboxApiCertificate == null
            ? null
            : sandboxApiCertificate!.toJson(),
        "sandbox_api_subject":
            sandboxApiSubject == null ? null : sandboxApiSubject!.toJson(),
        "paypal_hosted_settings": paypalHostedSettings == null
            ? null
            : paypalHostedSettings!.toJson(),
        "brand_name": brandName == null ? null : brandName!.toJson(),
        "logo_image_url": logoImageUrl == null ? null : logoImageUrl!.toJson(),
        "header_image_url":
            headerImageUrl == null ? null : headerImageUrl!.toJson(),
        "landing_page": landingPage == null ? null : landingPage!.toJson(),
        "require_billing":
            requireBilling == null ? null : requireBilling!.toJson(),
        "require_phone_number":
            requirePhoneNumber == null ? null : requirePhoneNumber!.toJson(),
        "instant_payments":
            instantPayments == null ? null : instantPayments!.toJson(),
        "subtotal_mismatch_behavior": subtotalMismatchBehavior == null
            ? null
            : subtotalMismatchBehavior!.toJson(),
        "button_settings":
            buttonSettings == null ? null : buttonSettings!.toJson(),
        "use_spb": useSpb == null ? null : useSpb!.toJson(),
        "button_color": buttonColor == null ? null : buttonColor!.toJson(),
        "button_shape": buttonShape == null ? null : buttonShape!.toJson(),
        "button_layout": buttonLayout == null ? null : buttonLayout!.toJson(),
        "button_size": buttonSize == null ? null : buttonSize!.toJson(),
        "hide_funding_methods":
            hideFundingMethods == null ? null : hideFundingMethods!.toJson(),
        "credit_enabled":
            creditEnabled == null ? null : creditEnabled!.toJson(),
        "cart_checkout_enabled":
            cartCheckoutEnabled == null ? null : cartCheckoutEnabled!.toJson(),
        "mini_cart_settings":
            miniCartSettings == null ? null : miniCartSettings!.toJson(),
        "mini_cart_settings_toggle": miniCartSettingsToggle == null
            ? null
            : miniCartSettingsToggle!.toJson(),
        "mini_cart_button_layout": miniCartButtonLayout == null
            ? null
            : miniCartButtonLayout!.toJson(),
        "mini_cart_button_size":
            miniCartButtonSize == null ? null : miniCartButtonSize!.toJson(),
        "mini_cart_hide_funding_methods": miniCartHideFundingMethods == null
            ? null
            : miniCartHideFundingMethods!.toJson(),
        "mini_cart_credit_enabled": miniCartCreditEnabled == null
            ? null
            : miniCartCreditEnabled!.toJson(),
        "single_product_settings": singleProductSettings == null
            ? null
            : singleProductSettings!.toJson(),
        "checkout_on_single_product_enabled":
            checkoutOnSingleProductEnabled == null
                ? null
                : checkoutOnSingleProductEnabled!.toJson(),
        "single_product_settings_toggle": singleProductSettingsToggle == null
            ? null
            : singleProductSettingsToggle!.toJson(),
        "single_product_button_layout": singleProductButtonLayout == null
            ? null
            : singleProductButtonLayout!.toJson(),
        "single_product_button_size": singleProductButtonSize == null
            ? null
            : singleProductButtonSize!.toJson(),
        "single_product_hide_funding_methods":
            singleProductHideFundingMethods == null
                ? null
                : singleProductHideFundingMethods!.toJson(),
        "single_product_credit_enabled": singleProductCreditEnabled == null
            ? null
            : singleProductCreditEnabled!.toJson(),
        "mark_settings": markSettings == null ? null : markSettings!.toJson(),
        "mark_enabled": markEnabled == null ? null : markEnabled!.toJson(),
        "mark_settings_toggle":
            markSettingsToggle == null ? null : markSettingsToggle!.toJson(),
        "mark_button_layout":
            markButtonLayout == null ? null : markButtonLayout!.toJson(),
        "mark_button_size":
            markButtonSize == null ? null : markButtonSize!.toJson(),
        "mark_hide_funding_methods": markHideFundingMethods == null
            ? null
            : markHideFundingMethods!.toJson(),
        "mark_credit_enabled":
            markCreditEnabled == null ? null : markCreditEnabled!.toJson(),
        "webhook": webhook == null ? null : webhook!.toJson(),
        "test_publishable_key":
            testPublishableKey == null ? null : testPublishableKey!.toJson(),
        "test_secret_key":
            testSecretKey == null ? null : testSecretKey!.toJson(),
        "test_webhook_secret":
            testWebhookSecret == null ? null : testWebhookSecret!.toJson(),
        "publishable_key":
            publishableKey == null ? null : publishableKey!.toJson(),
        "secret_key": secretKey == null ? null : secretKey!.toJson(),
        "webhook_secret":
            webhookSecret == null ? null : webhookSecret!.toJson(),
        "inline_cc_form": inlineCcForm == null ? null : inlineCcForm!.toJson(),
        "statement_descriptor":
            statementDescriptor == null ? null : statementDescriptor!.toJson(),
        "capture": capture == null ? null : capture!.toJson(),
        "payment_request":
            paymentRequest == null ? null : paymentRequest!.toJson(),
        "payment_request_button_type": paymentRequestButtonType == null
            ? null
            : paymentRequestButtonType!.toJson(),
        "payment_request_button_theme": paymentRequestButtonTheme == null
            ? null
            : paymentRequestButtonTheme!.toJson(),
        "payment_request_button_height": paymentRequestButtonHeight == null
            ? null
            : paymentRequestButtonHeight!.toJson(),
        "saved_cards": savedCards == null ? null : savedCards!.toJson(),
        "logging": logging == null ? null : logging!.toJson(),
      };
}

class Title {
  Title({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.titleDefault,
    this.tip,
    this.placeholder,
    this.options,
  });

  String? id;
  String? label;
  String? description;
  Type? type;
  String? value;
  String? titleDefault;
  String? tip;
  Placeholder? placeholder;
  TitleOptions? options;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
        id: json["id"],
        label: json["label"],
        description: json["description"],
        type: typeValues.map[json["type"]],
        value: json["value"],
        titleDefault: json["default"],
        tip: json["tip"],
        placeholder: placeholderValues.map[json["placeholder"]],
        options: json["options"] == null
            ? null
            : TitleOptions.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "description": description,
        "type": typeValues.reverse![type!],
        "value": value,
        "default": titleDefault,
        "tip": tip,
        "placeholder": placeholderValues.reverse![placeholder!],
        "options": options == null ? null : options!.toJson(),
      };
}

class TitleOptions {
  TitleOptions({
    this.gold,
    this.blue,
    this.silver,
    this.black,
    this.vertical,
    this.horizontal,
    this.pill,
    this.rect,
    this.responsive,
    this.small,
    this.medium,
    this.large,
    this.flatRate,
    this.freeShipping,
    this.localPickup,
    this.live,
    this.sandbox,
    this.billing,
    this.login,
    this.dark,
    this.light,
    this.lightOutline,
    this.optionsDefault,
    this.buy,
    this.donate,
    this.sale,
    this.authorization,
    this.add,
    this.drop,
  });

  String? gold;
  String? blue;
  String? silver;
  String? black;
  String? vertical;
  String? horizontal;
  String? pill;
  String? rect;
  String? responsive;
  String? small;
  String? medium;
  String? large;
  FlatRate? flatRate;
  FreeShipping? freeShipping;
  LocalPickup? localPickup;
  String? live;
  String? sandbox;
  String? billing;
  String? login;
  String? dark;
  String? light;
  String? lightOutline;
  String? optionsDefault;
  String? buy;
  String? donate;
  String? sale;
  String? authorization;
  String? add;
  String? drop;

  factory TitleOptions.fromJson(Map<String, dynamic> json) => TitleOptions(
        gold: json["gold"],
        blue: json["blue"],
        silver: json["silver"],
        black: json["black"],
        vertical: json["vertical"],
        horizontal: json["horizontal"],
        pill: json["pill"],
        rect: json["rect"],
        responsive: json["responsive"],
        small: json["small"],
        medium: json["medium"],
        large: json["large"],
        flatRate: json["Flat rate"] == null
            ? null
            : FlatRate.fromJson(json["Flat rate"]),
        freeShipping: json["Free shipping"] == null
            ? null
            : FreeShipping.fromJson(json["Free shipping"]),
        localPickup: json["Local pickup"] == null
            ? null
            : LocalPickup.fromJson(json["Local pickup"]),
        live: json["live"],
        sandbox: json["sandbox"],
        billing: json["Billing"],
        login: json["Login"],
        dark: json["dark"],
        light: json["light"],
        lightOutline: json["light-outline"],
        optionsDefault: json["default"],
        buy: json["buy"],
        donate: json["donate"],
        sale: json["sale"],
        authorization: json["authorization"],
        add: json["add"],
        drop: json["drop"],
      );

  Map<String, dynamic> toJson() => {
        "gold": gold,
        "blue": blue,
        "silver": silver,
        "black": black,
        "vertical": vertical,
        "horizontal": horizontal,
        "pill": pill,
        "rect": rect,
        "responsive": responsive,
        "small": small,
        "medium": medium,
        "large": large,
        "Flat rate": flatRate == null ? null : flatRate!.toJson(),
        "Free shipping": freeShipping == null ? null : freeShipping!.toJson(),
        "Local pickup": localPickup == null ? null : localPickup!.toJson(),
        "live": live,
        "sandbox": sandbox,
        "Billing": billing,
        "Login": login,
        "dark": dark,
        "light": light,
        "light-outline": lightOutline,
        "default": optionsDefault,
        "buy": buy,
        "donate": donate,
        "sale": sale,
        "authorization": authorization,
        "add": add,
        "drop": drop,
      };
}

enum Placeholder {
  empty,
  optional,
  optionalIfYouProvideACertificateBelow,
  youYourEmailCom
}

final placeholderValues = EnumValues({
  "": Placeholder.empty,
  "Optional": Placeholder.optional,
  "Optional if you provide a certificate below":
      Placeholder.optionalIfYouProvideACertificateBelow,
  "you@youremail.com": Placeholder.youYourEmailCom
});

enum Type {
  title,
  checkbox,
  file,
  password,
  text,
  select,
  email,
  multiselect,
  image,
  textarea
}

final typeValues = EnumValues({
  "checkbox": Type.checkbox,
  "email": Type.email,
  "file": Type.file,
  "image": Type.image,
  "multiselect": Type.multiselect,
  "password": Type.password,
  "select": Type.select,
  "text": Type.text,
  "textarea": Type.textarea,
  "title": Type.title
});

class HideFundingMethods {
  HideFundingMethods({
    this.id,
    this.label,
    this.description,
    this.type,
    this.value,
    this.hideFundingMethodsDefault,
    this.tip,
    this.placeholder,
    this.options,
  });

  String? id;
  String? label;
  String? description;
  Type? type;
  String? value;
  List<String>? hideFundingMethodsDefault;
  String? tip;
  String? placeholder;
  HideFundingMethodsOptions? options;

  factory HideFundingMethods.fromJson(Map<String, dynamic> json) =>
      HideFundingMethods(
        id: json["id"],
        label: json["label"],
        description: json["description"],
        type: typeValues.map[json["type"]],
        value: json["value"],
        hideFundingMethodsDefault:
            List<String>.from(json["default"].map((x) => x)),
        tip: json["tip"],
        placeholder: json["placeholder"],
        options: HideFundingMethodsOptions.fromJson(json["options"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "description": description,
        "type": typeValues.reverse![type!],
        "value": value,
        "default": List<dynamic>.from(hideFundingMethodsDefault!.map((x) => x)),
        "tip": tip,
        "placeholder": placeholder,
        "options": options!.toJson(),
      };
}

class HideFundingMethodsOptions {
  HideFundingMethodsOptions({
    this.credit,
    this.elv,
    this.card,
  });

  String? credit;
  String? elv;
  String? card;

  factory HideFundingMethodsOptions.fromJson(Map<String, dynamic> json) =>
      HideFundingMethodsOptions(
        credit: json["CREDIT"],
        elv: json["ELV"],
        card: json["CARD"],
      );

  Map<String, dynamic> toJson() => {
        "CREDIT": credit,
        "ELV": elv,
        "CARD": card,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
