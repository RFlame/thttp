import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
///
///    author : TaoTao
///    date   : 2020/4/26 10:37 AM
///    desc   : 自定义日子拦截器
///
class XLogInterceptor extends Interceptor {
  XLogInterceptor({
    this.request = true,
    this.requestHeader = true,
    this.requestBody = false,
    this.responseHeader = true,
    this.responseBody = false,
    this.error = true,
  });

  /// Print request [Options]
  bool request;

  /// Print request header [Options.headers]
  bool requestHeader;

  /// Print request data [Options.data]
  bool requestBody;

  /// Print [Response.data]
  bool responseBody;

  /// Print [Response.headers]
  bool responseHeader;

  /// Print error message
  bool error;

  /// Log printer; defaults print log to console.
  /// In flutter, you'd better use debugPrint.
  /// you can also write log in a file, for example:
  ///```dart
  ///  var file=File("./log.txt");
  ///  var sink=file.openWrite();
  ///  dio.interceptors.add(LogInterceptor(logPrint: sink.writeln));
  ///  ...
  ///  await sink.close();
  ///```
  void logPrint(String msg) {
    debugPrint(msg, wrapWidth: 1024);
  }

  @override
  Future onRequest(RequestOptions options) async {
    logPrint('*** Request ***');
    printKV('uri', options.uri);

    if (request) {
      printKV('method', options.method);
      printKV('responseType', options.responseType?.toString());
      printKV('followRedirects', options.followRedirects);
      printKV('connectTimeout', options.connectTimeout);
      printKV('receiveTimeout', options.receiveTimeout);
      printKV('extra', options.extra);
    }
    if (requestHeader) {
      logPrint('headers:');
      options.headers.forEach((key, v) => printKV(' $key', v));
    }
    if (requestBody) {
      logPrint('data:');
      logPrint('${options.data.toString()}');
    }
    logPrint('');
  }

  @override
  Future onError(DioError err) async {
    if (error) {
      logPrint('*** DioError ***:');
      logPrint('uri: ${err.request.uri}');
      logPrint('$err');
      if (err.response != null) {
        _printResponse(err.response);
      }
      logPrint('');
    }
  }

  @override
  Future onResponse(Response response) async {
    logPrint('*** Response ***');
    _printResponse(response);
  }

  void _printResponse(Response response) {
    printKV('uri', response.request?.uri);
    if (responseHeader) {
      printKV('statusCode', response.statusCode);
      if (response.isRedirect == true) {
        printKV('redirect', response.realUri);
      }
      if (response.headers != null) {
        logPrint('headers:');
        response.headers.forEach((key, v) => printKV(' $key', v.join(',')));
      }
    }
    if (responseBody) {
      logPrint('Response Text:');
      printAll(response.toString());
    }
    logPrint('');
  }

  void printKV(String key, Object v) {
    logPrint('$key: $v');
  }

  void printAll(msg) {
//    msg.toString().split('\n').forEach(logPrint);
    logPrint(msg);
  }
}