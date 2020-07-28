import 'package:thttp/thttp.dart';

///
///    author : TaoTao
///    date   : 2020/3/9 2:00 PM
///    desc   : 自定义拦截器
///
class TestCustomInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    print('CustomInterceptor onRequest:${options?.method} => PATH:${options?.path}');
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    print('CustomInterceptor onResponse:${response?.statusCode} => PATH:${response?.request?.path}');
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    print('CustomInterceptor onError:${err?.response?.statusCode} => PATH:${err?.request?.path}');
    return super.onError(err);
  }

}