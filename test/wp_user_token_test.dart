import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:woosignal/networking/api_provider.dart';
import 'package:woosignal/woosignal.dart';

const String _token =
    "0123456789abcdef0123456789abcdef0123456789abcdef0123456789abcdef";

/// Captures outgoing requests and answers them without touching the network.
class _CaptureInterceptor extends Interceptor {
  final List<RequestOptions> requests = [];
  dynamic responseData;
  bool fail = false;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    requests.add(options);
    if (fail) {
      handler.reject(DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          message: "offline"));
      return;
    }
    handler.resolve(
        Response(requestOptions: options, statusCode: 200, data: responseData));
  }
}

_CaptureInterceptor _attach(Dio dio) {
  _CaptureInterceptor interceptor = _CaptureInterceptor();
  dio.interceptors.add(interceptor);
  return interceptor;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ApiProvider X-WS-User-Token header', () {
    late ApiProvider provider;
    late _CaptureInterceptor capture;

    setUp(() async {
      provider =
          ApiProvider(appKey: "app_key", version: "4.6.0", debugMode: false);
      await provider.init();
      capture = _attach(provider.dio);
    });

    test('is absent when a token was never set', () async {
      await provider.get("/app");

      expect(
          capture.requests.single.headers
              .containsKey(ApiProvider.wpUserTokenHeader),
          isFalse);
      expect(provider.hasWpUserToken, isFalse);
    });

    test('is sent on GET and POST requests when set', () async {
      provider.setWpUserToken(_token);

      await provider.get("/app");
      await provider.post("/request", {"type": "get", "path": "orders"});

      expect(capture.requests, hasLength(2));
      for (RequestOptions request in capture.requests) {
        expect(request.headers[ApiProvider.wpUserTokenHeader], _token);
        expect(request.headers["Authorization"], "Bearer app_key");
        expect(request.headers.containsKey("X-DMETA"), isTrue);
      }
    });

    test('is removed when cleared with null', () async {
      provider.setWpUserToken(_token);
      provider.setWpUserToken(null);

      await provider.get("/app");

      expect(
          capture.requests.single.headers
              .containsKey(ApiProvider.wpUserTokenHeader),
          isFalse);
      expect(provider.hasWpUserToken, isFalse);
    });

    test('is removed when cleared with an empty string', () async {
      provider.setWpUserToken(_token);
      provider.setWpUserToken("");

      await provider.get("/app");

      expect(
          capture.requests.single.headers
              .containsKey(ApiProvider.wpUserTokenHeader),
          isFalse);
    });

    test('survives other header updates', () async {
      provider.setWpUserToken(_token);
      provider.setWpUserId("12");
      provider.setFcmToken("fcm");

      await provider.get("/app");

      expect(capture.requests.single.headers[ApiProvider.wpUserTokenHeader],
          _token);
    });

    test('set before init is applied once initialized', () async {
      ApiProvider early =
          ApiProvider(appKey: "app_key", version: "4.6.0", debugMode: false);
      early.setWpUserToken(_token);
      await early.init();
      _CaptureInterceptor earlyCapture = _attach(early.dio);

      await early.get("/app");

      expect(
          earlyCapture.requests.single.headers[ApiProvider.wpUserTokenHeader],
          _token);
    });
  });

  group('WooSignal wp user token', () {
    late List<String> logs;
    late DebugPrintCallback originalDebugPrint;

    setUp(() {
      logs = [];
      originalDebugPrint = debugPrint;
      debugPrint = (String? message, {int? wrapWidth}) {
        if (message != null) logs.add(message);
      };
    });

    tearDown(() {
      debugPrint = originalDebugPrint;
      WooSignal.instance.setWpUserToken(null);
    });

    test('init(wpUserToken:) sends the header', () async {
      await WooSignal.instance
          .init(appKey: "app_key", debugMode: true, wpUserToken: _token);
      _CaptureInterceptor capture = _attach(WooSignal.instance.apiProvider.dio);
      capture.responseData = [];

      await WooSignal.instance.getOrders(customer: 12);

      expect(capture.requests.single.headers[ApiProvider.wpUserTokenHeader],
          _token);
    });

    test('setWpUserToken sets and clears the header', () async {
      await WooSignal.instance.init(appKey: "app_key", debugMode: true);
      _CaptureInterceptor capture = _attach(WooSignal.instance.apiProvider.dio);
      capture.responseData = [];

      await WooSignal.instance.getOrders(customer: 12);
      WooSignal.instance.setWpUserToken(_token);
      await WooSignal.instance.getOrders(customer: 12);
      WooSignal.instance.setWpUserToken(null);
      await WooSignal.instance.getOrders(customer: 12);

      expect(capture.requests, hasLength(3));
      expect(
          capture.requests[0].headers
              .containsKey(ApiProvider.wpUserTokenHeader),
          isFalse);
      expect(
          capture.requests[1].headers[ApiProvider.wpUserTokenHeader], _token);
      expect(
          capture.requests[2].headers
              .containsKey(ApiProvider.wpUserTokenHeader),
          isFalse);
    });

    test('setWpUserToken before init is applied by init', () async {
      WooSignal.instance.setWpUserToken(_token);
      await WooSignal.instance.init(appKey: "app_key", debugMode: true);
      _CaptureInterceptor capture = _attach(WooSignal.instance.apiProvider.dio);
      capture.responseData = [];

      await WooSignal.instance.getOrders(customer: 12);

      expect(capture.requests.single.headers[ApiProvider.wpUserTokenHeader],
          _token);
    });

    test('the token is never logged in debug mode', () async {
      await WooSignal.instance
          .init(appKey: "app_key", debugMode: true, wpUserToken: _token);
      _CaptureInterceptor capture = _attach(WooSignal.instance.apiProvider.dio);
      capture.responseData = {"id": 1, "code": "points-abc", "amount": "5.00"};

      await WooSignal.instance.redeemPoints(wpUserToken: _token, points: 100);
      capture.responseData = [];
      await WooSignal.instance.getOrders(customer: 12);
      // Failed requests log the error; the token must not appear there either.
      capture.fail = true;
      await WooSignal.instance.getApp();

      expect(logs, isNotEmpty);
      expect(logs.any((log) => log.contains("Parameters:")), isTrue);
      expect(logs.any((log) => log.contains("[REDACTED]")), isTrue);
      for (String log in logs) {
        expect(log, isNot(contains(_token)));
      }
      // The token is still sent in the request body to the API.
      expect(capture.requests.first.data.toString(), contains(_token));
    });
  });

  group('failed requests', () {
    setUp(() async {
      await WooSignal.instance.init(appKey: "app_key", debugMode: false);
    });

    test('an error response gives an empty order list, not a crash', () async {
      _CaptureInterceptor capture = _attach(WooSignal.instance.apiProvider.dio);
      capture.responseData = {"error": "Please log in to see your orders."};

      expect(await WooSignal.instance.getOrders(customer: 12), isEmpty);
    });

    test('a response of the wrong shape doesn\'t crash', () async {
      _CaptureInterceptor capture = _attach(WooSignal.instance.apiProvider.dio);
      capture.responseData = {"unexpected": true};

      // Parsing a map as a list throws a TypeError, which used to escape
      expect(await WooSignal.instance.getOrders(customer: 12), isEmpty);
      await WooSignal.instance.retrieveOrder(5);
    });

    test('a network failure gives an empty order list, not a crash', () async {
      _CaptureInterceptor capture = _attach(WooSignal.instance.apiProvider.dio);
      capture.fail = true;

      expect(await WooSignal.instance.getOrders(customer: 12), isEmpty);
    });
  });
}
