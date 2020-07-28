import 'package:thttp/src/http_config.dart';
import 'package:thttp/src/xhttp_config.dart';
import 'package:thttp/thttp.dart';

abstract class BaseRequest<R extends BaseRequest<R>> {

  HttpGlobalConfig httpGlobalConfig;
  //基础域名
  String baseUrl;
  //请求头
  Map<String, dynamic> headers = {};
  //请求参数
  Map<String, dynamic> params = {};
  //读取超时时间
  int readTimeOut;
  //写入超时时间
  int writeTimeOut;
  //连接超时时间
  int connectTimeOut;
  //拦截器
  List<dynamic> interceptors = [];
  //打印日志开关
  bool _logPrint = false;
  //响应数据类型
  XResponseType _xResponseType = XResponseType.json;
  //认证证书地址
  String _sslFilePath;
  //httpProxy地址
  String _httpProxy;

  bool get logPrint => _logPrint;
  XResponseType get xResponseType => _xResponseType;
  String get sslFilePath => _sslFilePath;
  String get httpProxy => _httpProxy;

  R setBaseUrl(String baseUrl) {
    if(baseUrl != null) {
      this.baseUrl = baseUrl;
    }
    return this;
  }

  R addHeaders(Map<String, dynamic> headers) {
    this.headers.addAll(headers);
    return this;
  }

  R addHeader(String headerKey, dynamic headerValue) {
    headers[headerKey] = headerValue;
    return this;
  }

  R addParams(Map<String, dynamic> params) {
    this.params.addAll(params);
    return this;
  }

  R addParam(String paramKey, dynamic paramValue) {
    params[paramKey] = paramValue;
    return this;
  }

  R addInterceptor(dynamic interceptorsWrapper) {
    interceptors.add(interceptorsWrapper);
    return this;
  }

  R addInterceptors(List<dynamic> interceptors) {
    this.interceptors.addAll(interceptors);
    return this;
  }

  //设置响应数据类型
  R setResponseType(XResponseType xResponseType) {
    _xResponseType = xResponseType;
    return this;
  }

  ///生成局部配置
  ///根据全局配置生成局部配置
  generateLocalConfig() {
    httpGlobalConfig = THttp.config();
    _logPrint = httpGlobalConfig.logPrint;
    if(httpGlobalConfig.baseUrl == null) {
      httpGlobalConfig.setBaseUrl(ZyConfig.API_HOST);
    }
    if(baseUrl == null || baseUrl.isEmpty) {
      baseUrl = httpGlobalConfig.baseUrl;
    }
    if(connectTimeOut == null || connectTimeOut <= -1) {
      if(httpGlobalConfig.connectTimeOut > -1) {
        connectTimeOut = httpGlobalConfig.connectTimeOut;
      }
    }

    if(readTimeOut == null || readTimeOut <= -1) {
      if(httpGlobalConfig.readTimeOut > -1) {
        readTimeOut = httpGlobalConfig.readTimeOut;
      }
    }

    if(writeTimeOut == null || writeTimeOut <= -1) {
      if(httpGlobalConfig.writeTimeOut > -1) {
        writeTimeOut = httpGlobalConfig.writeTimeOut;
      }
    }

    if(httpGlobalConfig.globalHeaders.isNotEmpty) {
      headers.addAll(httpGlobalConfig.globalHeaders);
    }
    if(httpGlobalConfig.params.isNotEmpty) {
      params.addAll(httpGlobalConfig.params);
    }

    if(_xResponseType == null) {
      if(httpGlobalConfig.xResponseType != null) {
        _xResponseType = httpGlobalConfig.xResponseType;
      } else {
        _xResponseType = ZyConfig.DEFAULT_ZY_RESPONSE_TYPE;
      }
    }

    if(httpGlobalConfig.sslFilePath != null) {
      _sslFilePath = httpGlobalConfig.sslFilePath;
    }

    if(httpGlobalConfig.httpProxy != null) {
    _httpProxy = httpGlobalConfig.httpProxy;
    }

    if(httpGlobalConfig.globalInterceptors.isNotEmpty) {
      interceptors.addAll(httpGlobalConfig.globalInterceptors);
    }
  }

  Future<XResponse> request() async{
    generateLocalConfig();
    return execute();
  }

  configClient();
  Future<XResponse> execute();
}