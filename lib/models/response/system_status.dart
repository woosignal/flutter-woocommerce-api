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

class SystemStatus {
  SystemStatus({
    this.environment,
    this.database,
    this.activePlugins,
    this.theme,
    this.settings,
    this.security,
    this.pages,
  });

  Environment? environment;
  Database? database;
  List<ActivePlugin>? activePlugins;
  Theme? theme;
  Settings? settings;
  Security? security;
  List<Page>? pages;

  factory SystemStatus.fromJson(Map<String, dynamic> json) => SystemStatus(
        environment: Environment.fromJson(json["environment"]),
        database: Database.fromJson(json["database"]),
        activePlugins: List<ActivePlugin>.from(
            json["active_plugins"].map((x) => ActivePlugin.fromJson(x))),
        theme: Theme.fromJson(json["theme"]),
        settings: Settings.fromJson(json["settings"]),
        security: Security.fromJson(json["security"]),
        pages: List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "environment": environment!.toJson(),
        "database": database!.toJson(),
        "active_plugins":
            List<dynamic>.from(activePlugins!.map((x) => x.toJson())),
        "theme": theme!.toJson(),
        "settings": settings!.toJson(),
        "security": security!.toJson(),
        "pages": List<dynamic>.from(pages!.map((x) => x.toJson())),
      };
}

class ActivePlugin {
  ActivePlugin({
    this.plugin,
    this.name,
    this.version,
    this.versionLatest,
    this.url,
    this.authorName,
    this.authorUrl,
    this.networkActivated,
  });

  String? plugin;
  String? name;
  String? version;
  String? versionLatest;
  String? url;
  String? authorName;
  String? authorUrl;
  bool? networkActivated;

  factory ActivePlugin.fromJson(Map<String, dynamic> json) => ActivePlugin(
        plugin: json["plugin"],
        name: json["name"],
        version: json["version"],
        versionLatest: json["version_latest"],
        url: json["url"],
        authorName: json["author_name"],
        authorUrl: json["author_url"],
        networkActivated: json["network_activated"],
      );

  Map<String, dynamic> toJson() => {
        "plugin": plugin,
        "name": name,
        "version": version,
        "version_latest": versionLatest,
        "url": url,
        "author_name": authorName,
        "author_url": authorUrl,
        "network_activated": networkActivated,
      };
}

class Database {
  Database({
    this.wcDatabaseVersion,
    this.databasePrefix,
    this.maxmindGeoipDatabase,
    this.databaseTables,
    this.databaseSize,
  });

  String? wcDatabaseVersion;
  String? databasePrefix;
  String? maxmindGeoipDatabase;
  DatabaseTables? databaseTables;
  DatabaseSize? databaseSize;

  factory Database.fromJson(Map<String, dynamic> json) => Database(
        wcDatabaseVersion: json["wc_database_version"],
        databasePrefix: json["database_prefix"],
        maxmindGeoipDatabase: json["maxmind_geoip_database"],
        databaseTables: DatabaseTables.fromJson(json["database_tables"]),
        databaseSize: DatabaseSize.fromJson(json["database_size"]),
      );

  Map<String, dynamic> toJson() => {
        "wc_database_version": wcDatabaseVersion,
        "database_prefix": databasePrefix,
        "maxmind_geoip_database": maxmindGeoipDatabase,
        "database_tables": databaseTables!.toJson(),
        "database_size": databaseSize!.toJson(),
      };
}

class DatabaseSize {
  DatabaseSize({
    this.data,
    this.index,
  });

  double? data;
  double? index;

  factory DatabaseSize.fromJson(Map<String, dynamic> json) => DatabaseSize(
        data: json["data"].toDouble(),
        index: json["index"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "index": index,
      };
}

class DatabaseTables {
  DatabaseTables({
    this.woocommerce,
    this.other,
  });

  Map<String, Other>? woocommerce;
  Map<String, Other>? other;

  factory DatabaseTables.fromJson(Map<String, dynamic> json) => DatabaseTables(
        woocommerce: Map.from(json["woocommerce"])
            .map((k, v) => MapEntry<String, Other>(k, Other.fromJson(v))),
        other: Map.from(json["other"])
            .map((k, v) => MapEntry<String, Other>(k, Other.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "woocommerce": Map.from(woocommerce!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "other": Map.from(other!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class Other {
  Other({
    this.data,
    this.index,
  });

  String? data;
  String? index;

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        data: json["data"],
        index: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "data": data,
        "index": index,
      };
}

class Environment {
  Environment({
    this.homeUrl,
    this.siteUrl,
    this.version,
    this.logDirectory,
    this.logDirectoryWritable,
    this.wpVersion,
    this.wpMultisite,
    this.wpMemoryLimit,
    this.wpDebugMode,
    this.wpCron,
    this.language,
    this.externalObjectCache,
    this.serverInfo,
    this.phpVersion,
    this.phpPostMaxSize,
    this.phpMaxExecutionTime,
    this.phpMaxInputVars,
    this.curlVersion,
    this.suhosinInstalled,
    this.maxUploadSize,
    this.mysqlVersion,
    this.mysqlVersionString,
    this.defaultTimezone,
    this.fsockopenOrCurlEnabled,
    this.soapclientEnabled,
    this.domdocumentEnabled,
    this.gzipEnabled,
    this.mbstringEnabled,
    this.remotePostSuccessful,
    this.remotePostResponse,
    this.remoteGetSuccessful,
    this.remoteGetResponse,
  });

  String? homeUrl;
  String? siteUrl;
  String? version;
  String? logDirectory;
  bool? logDirectoryWritable;
  String? wpVersion;
  bool? wpMultisite;
  int? wpMemoryLimit;
  bool? wpDebugMode;
  bool? wpCron;
  String? language;
  dynamic externalObjectCache;
  String? serverInfo;
  String? phpVersion;
  int? phpPostMaxSize;
  int? phpMaxExecutionTime;
  int? phpMaxInputVars;
  String? curlVersion;
  bool? suhosinInstalled;
  int? maxUploadSize;
  String? mysqlVersion;
  String? mysqlVersionString;
  String? defaultTimezone;
  bool? fsockopenOrCurlEnabled;
  bool? soapclientEnabled;
  bool? domdocumentEnabled;
  bool? gzipEnabled;
  bool? mbstringEnabled;
  bool? remotePostSuccessful;
  String? remotePostResponse;
  bool? remoteGetSuccessful;
  String? remoteGetResponse;

  factory Environment.fromJson(Map<String, dynamic> json) => Environment(
        homeUrl: json["home_url"],
        siteUrl: json["site_url"],
        version: json["version"],
        logDirectory: json["log_directory"],
        logDirectoryWritable: json["log_directory_writable"],
        wpVersion: json["wp_version"],
        wpMultisite: json["wp_multisite"],
        wpMemoryLimit: json["wp_memory_limit"],
        wpDebugMode: json["wp_debug_mode"],
        wpCron: json["wp_cron"],
        language: json["language"],
        externalObjectCache: json["external_object_cache"],
        serverInfo: json["server_info"],
        phpVersion: json["php_version"],
        phpPostMaxSize: json["php_post_max_size"],
        phpMaxExecutionTime: json["php_max_execution_time"],
        phpMaxInputVars: json["php_max_input_vars"],
        curlVersion: json["curl_version"],
        suhosinInstalled: json["suhosin_installed"],
        maxUploadSize: json["max_upload_size"],
        mysqlVersion: json["mysql_version"],
        mysqlVersionString: json["mysql_version_string"],
        defaultTimezone: json["default_timezone"],
        fsockopenOrCurlEnabled: json["fsockopen_or_curl_enabled"],
        soapclientEnabled: json["soapclient_enabled"],
        domdocumentEnabled: json["domdocument_enabled"],
        gzipEnabled: json["gzip_enabled"],
        mbstringEnabled: json["mbstring_enabled"],
        remotePostSuccessful: json["remote_post_successful"],
        remotePostResponse: json["remote_post_response"],
        remoteGetSuccessful: json["remote_get_successful"],
        remoteGetResponse: json["remote_get_response"],
      );

  Map<String, dynamic> toJson() => {
        "home_url": homeUrl,
        "site_url": siteUrl,
        "version": version,
        "log_directory": logDirectory,
        "log_directory_writable": logDirectoryWritable,
        "wp_version": wpVersion,
        "wp_multisite": wpMultisite,
        "wp_memory_limit": wpMemoryLimit,
        "wp_debug_mode": wpDebugMode,
        "wp_cron": wpCron,
        "language": language,
        "external_object_cache": externalObjectCache,
        "server_info": serverInfo,
        "php_version": phpVersion,
        "php_post_max_size": phpPostMaxSize,
        "php_max_execution_time": phpMaxExecutionTime,
        "php_max_input_vars": phpMaxInputVars,
        "curl_version": curlVersion,
        "suhosin_installed": suhosinInstalled,
        "max_upload_size": maxUploadSize,
        "mysql_version": mysqlVersion,
        "mysql_version_string": mysqlVersionString,
        "default_timezone": defaultTimezone,
        "fsockopen_or_curl_enabled": fsockopenOrCurlEnabled,
        "soapclient_enabled": soapclientEnabled,
        "domdocument_enabled": domdocumentEnabled,
        "gzip_enabled": gzipEnabled,
        "mbstring_enabled": mbstringEnabled,
        "remote_post_successful": remotePostSuccessful,
        "remote_post_response": remotePostResponse,
        "remote_get_successful": remoteGetSuccessful,
        "remote_get_response": remoteGetResponse,
      };
}

class Page {
  Page({
    this.pageName,
    this.pageId,
    this.pageSet,
    this.pageExists,
    this.pageVisible,
    this.shortcode,
    this.shortcodeRequired,
    this.shortcodePresent,
  });

  String? pageName;
  String? pageId;
  bool? pageSet;
  bool? pageExists;
  bool? pageVisible;
  String? shortcode;
  bool? shortcodeRequired;
  bool? shortcodePresent;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        pageName: json["page_name"],
        pageId: json["page_id"],
        pageSet: json["page_set"],
        pageExists: json["page_exists"],
        pageVisible: json["page_visible"],
        shortcode: json["shortcode"],
        shortcodeRequired: json["shortcode_required"],
        shortcodePresent: json["shortcode_present"],
      );

  Map<String, dynamic> toJson() => {
        "page_name": pageName,
        "page_id": pageId,
        "page_set": pageSet,
        "page_exists": pageExists,
        "page_visible": pageVisible,
        "shortcode": shortcode,
        "shortcode_required": shortcodeRequired,
        "shortcode_present": shortcodePresent,
      };
}

class Security {
  Security({
    this.secureConnection,
    this.hideErrors,
  });

  bool? secureConnection;
  bool? hideErrors;

  factory Security.fromJson(Map<String, dynamic> json) => Security(
        secureConnection: json["secure_connection"],
        hideErrors: json["hide_errors"],
      );

  Map<String, dynamic> toJson() => {
        "secure_connection": secureConnection,
        "hide_errors": hideErrors,
      };
}

class Settings {
  Settings({
    this.apiEnabled,
    this.forceSsl,
    this.currency,
    this.currencySymbol,
    this.currencyPosition,
    this.thousandSeparator,
    this.decimalSeparator,
    this.numberOfDecimals,
    this.geolocationEnabled,
    this.taxonomies,
    this.productVisibilityTerms,
  });

  bool? apiEnabled;
  bool? forceSsl;
  String? currency;
  String? currencySymbol;
  String? currencyPosition;
  String? thousandSeparator;
  String? decimalSeparator;
  int? numberOfDecimals;
  bool? geolocationEnabled;
  Taxonomies? taxonomies;
  ProductVisibilityTerms? productVisibilityTerms;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        apiEnabled: json["api_enabled"],
        forceSsl: json["force_ssl"],
        currency: json["currency"],
        currencySymbol: json["currency_symbol"],
        currencyPosition: json["currency_position"],
        thousandSeparator: json["thousand_separator"],
        decimalSeparator: json["decimal_separator"],
        numberOfDecimals: json["number_of_decimals"],
        geolocationEnabled: json["geolocation_enabled"],
        taxonomies: Taxonomies.fromJson(json["taxonomies"]),
        productVisibilityTerms:
            ProductVisibilityTerms.fromJson(json["product_visibility_terms"]),
      );

  Map<String, dynamic> toJson() => {
        "api_enabled": apiEnabled,
        "force_ssl": forceSsl,
        "currency": currency,
        "currency_symbol": currencySymbol,
        "currency_position": currencyPosition,
        "thousand_separator": thousandSeparator,
        "decimal_separator": decimalSeparator,
        "number_of_decimals": numberOfDecimals,
        "geolocation_enabled": geolocationEnabled,
        "taxonomies": taxonomies!.toJson(),
        "product_visibility_terms": productVisibilityTerms!.toJson(),
      };
}

class ProductVisibilityTerms {
  ProductVisibilityTerms({
    this.excludeFromCatalog,
    this.excludeFromSearch,
    this.featured,
    this.outofstock,
    this.rated1,
    this.rated2,
    this.rated3,
    this.rated4,
    this.rated5,
  });

  String? excludeFromCatalog;
  String? excludeFromSearch;
  String? featured;
  String? outofstock;
  String? rated1;
  String? rated2;
  String? rated3;
  String? rated4;
  String? rated5;

  factory ProductVisibilityTerms.fromJson(Map<String, dynamic> json) =>
      ProductVisibilityTerms(
        excludeFromCatalog: json["exclude-from-catalog"],
        excludeFromSearch: json["exclude-from-search"],
        featured: json["featured"],
        outofstock: json["outofstock"],
        rated1: json["rated-1"],
        rated2: json["rated-2"],
        rated3: json["rated-3"],
        rated4: json["rated-4"],
        rated5: json["rated-5"],
      );

  Map<String, dynamic> toJson() => {
        "exclude-from-catalog": excludeFromCatalog,
        "exclude-from-search": excludeFromSearch,
        "featured": featured,
        "outofstock": outofstock,
        "rated-1": rated1,
        "rated-2": rated2,
        "rated-3": rated3,
        "rated-4": rated4,
        "rated-5": rated5,
      };
}

class Taxonomies {
  Taxonomies({
    this.taxonomiesExternal,
    this.grouped,
    this.simple,
    this.variable,
  });

  String? taxonomiesExternal;
  String? grouped;
  String? simple;
  String? variable;

  factory Taxonomies.fromJson(Map<String, dynamic> json) => Taxonomies(
        taxonomiesExternal: json["external"],
        grouped: json["grouped"],
        simple: json["simple"],
        variable: json["variable"],
      );

  Map<String, dynamic> toJson() => {
        "external": taxonomiesExternal,
        "grouped": grouped,
        "simple": simple,
        "variable": variable,
      };
}

class Theme {
  Theme({
    this.name,
    this.version,
    this.versionLatest,
    this.authorUrl,
    this.isChildTheme,
    this.hasWoocommerceSupport,
    this.hasWoocommerceFile,
    this.hasOutdatedTemplates,
    this.overrides,
    this.parentName,
    this.parentVersion,
    this.parentVersionLatest,
    this.parentAuthorUrl,
  });

  String? name;
  String? version;
  String? versionLatest;
  String? authorUrl;
  bool? isChildTheme;
  bool? hasWoocommerceSupport;
  bool? hasWoocommerceFile;
  bool? hasOutdatedTemplates;
  List<dynamic>? overrides;
  String? parentName;
  String? parentVersion;
  String? parentVersionLatest;
  String? parentAuthorUrl;

  factory Theme.fromJson(Map<String, dynamic> json) => Theme(
        name: json["name"],
        version: json["version"],
        versionLatest: json["version_latest"],
        authorUrl: json["author_url"],
        isChildTheme: json["is_child_theme"],
        hasWoocommerceSupport: json["has_woocommerce_support"],
        hasWoocommerceFile: json["has_woocommerce_file"],
        hasOutdatedTemplates: json["has_outdated_templates"],
        overrides: List<dynamic>.from(json["overrides"].map((x) => x)),
        parentName: json["parent_name"],
        parentVersion: json["parent_version"],
        parentVersionLatest: json["parent_version_latest"],
        parentAuthorUrl: json["parent_author_url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "version": version,
        "version_latest": versionLatest,
        "author_url": authorUrl,
        "is_child_theme": isChildTheme,
        "has_woocommerce_support": hasWoocommerceSupport,
        "has_woocommerce_file": hasWoocommerceFile,
        "has_outdated_templates": hasOutdatedTemplates,
        "overrides": List<dynamic>.from(overrides!.map((x) => x)),
        "parent_name": parentName,
        "parent_version": parentVersion,
        "parent_version_latest": parentVersionLatest,
        "parent_author_url": parentAuthorUrl,
      };
}
