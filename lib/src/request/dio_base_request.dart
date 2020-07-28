import 'dart:io';
import 'package:flutter/services.dart';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:thttp/src/interceptor/log_interceptor.dart';

import 'package:thttp/src/request/base_request.dart';
import 'package:thttp/src/mode/xhttp_response.dart';
import 'package:thttp/src/mode/xhttp_error.dart';
import 'package:thttp/src/util/xhttp_util.dart';

///
///    author : TaoTao
///    date   : 2020/3/9 2:08 PM
///    desc   : Dio请求基类
///
class DioBaseRequest<R extends DioBaseRequest<R>> extends BaseRequest<R> {
  String suffixUrl;
  String method;

  @override
  configClient() async {
    ResponseType responseType = DioHttpUtil.getDioResponseType(xResponseType);
    Dio dio = Dio(BaseOptions(
        method: method,
        baseUrl: baseUrl,
        headers: headers,
        contentType: headers != null && headers.containsKey('content-type') ? headers['content-type'] : null,
        connectTimeout: connectTimeOut,
        receiveTimeout: readTimeOut,
        sendTimeout: writeTimeOut,
        responseType: responseType));

    ///添加自定义拦截器
    if (interceptors.isNotEmpty) {
      for (dynamic o in interceptors) {
        if (o is InterceptorsWrapper) {
          dio.interceptors.add(o);
        }
      }
    }

    ///增加日志拦截器，添加在队尾
    if (logPrint) {
      dio.interceptors
          .add(XLogInterceptor(requestBody: true, responseBody: true));
    }

    ///http证书验证
    if (sslFilePath != null && sslFilePath.isNotEmpty) {
      ByteData certBytes = await rootBundle.load(sslFilePath);
      if (certBytes != null) {
        (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
            (client) {
          SecurityContext sc = SecurityContext();
          sc.setTrustedCertificatesBytes(certBytes.buffer.asUint8List());
          HttpClient httpClient = HttpClient(context: sc);
          return httpClient;
        };
      }
    }

    //http代理
    if (httpProxy != null && httpProxy.isNotEmpty) {
      (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (client) {
        client.findProxy = (url) {
          return 'PROXY $httpProxy';
        };
      };
    }

    return dio;
  }

  @override
  Future<XResponse> execute() async {
    XResponse zyResponse = XResponse();
    ResponseType responseType = DioHttpUtil.getDioResponseType(xResponseType);
    try {
      Dio dio = await configClient() as Dio;

      ///统一返回数据格式
      if (responseType == ResponseType.stream) {
        Response<ResponseBody> response = await dio.request<ResponseBody>(
          suffixUrl,
            data: method.toUpperCase() == "GET" || method.toUpperCase() == "DELETE" ? {} : params,
            queryParameters: method.toUpperCase() == "GET" || method.toUpperCase() == "DELETE"? params : {}
        );
        zyResponse.stream = response?.data?.stream;
      } else if (responseType == ResponseType.bytes) {
        Response<List<int>> response = await dio.request<List<int>>(
            suffixUrl,
            data: method.toUpperCase() == "GET" || method.toUpperCase() == "DELETE" ? {} : params,
            queryParameters: method.toUpperCase() == "GET" || method.toUpperCase() == "DELETE" ? params : {}
        );
        zyResponse.bytesData = response?.data;
      } else {
        Response response = await dio.request(
            suffixUrl,
            data: method.toUpperCase() == "GET" || method.toUpperCase() == "DELETE" ? {} : params,
            queryParameters: method.toUpperCase() == "GET" || method.toUpperCase() == "DELETE" ? params : {}
        );
        zyResponse.data = response?.data;
      }
    } on DioError catch (e) {
      print('get error -----$e');
      //TODO 统一处理错误
      zyResponse.httpError = XHttpError(e?.type?.index, e?.message);
      if(e?.response != null) {
        zyResponse?.data = e?.response?.data;
      }
      return zyResponse;
    }
    return zyResponse;
  }
}
