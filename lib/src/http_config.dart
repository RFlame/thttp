import 'package:thttp/src/mode/xhttp_response.dart';
import 'package:thttp/src/xhttp_config.dart';
///
///    author : TaoTao
///    date   : 2020/3/9 10:13 AM
///    desc   : 配置类
///
class HttpGlobalConfig {

  //请求头
  Map<String, dynamic> globalHeaders = {};
  //请求参数
  Map<String, dynamic> params = {};
  //基础域名
  String baseUrl;
  //请求失败重试间隔时间
  int retryDelayMillis;
  //请求失败重试次数
  int retryCount;
  //读取超时时间
  int readTimeOut = ZyConfig.DEFAULT_TIMEOUT;
  //写入超时时间
  int writeTimeOut = ZyConfig.DEFAULT_TIMEOUT;
  //连接超时时间
  int connectTimeOut = ZyConfig.DEFAULT_TIMEOUT;
  //拦截器
  List<dynamic> globalInterceptors = [];
  //打印日志开关
  bool logPrint = false;
  //响应数据类型
  XResponseType xResponseType = ZyConfig.DEFAULT_ZY_RESPONSE_TYPE;
  //认证证书地址
  String _sslFilePath;
  //httpProxy地址
  String _httpProxy;

  static final _instance = HttpGlobalConfig();
  static HttpGlobalConfig get singleton => _instance;
  String get sslFilePath => _sslFilePath;
  String get httpProxy => _httpProxy;

  HttpGlobalConfig addHeaders(Map<String, dynamic> globalHeaders) {
    this.globalHeaders = globalHeaders;
    return this;
  }

  HttpGlobalConfig addHeader(String headerKey, String headerValue) {
    globalHeaders[headerKey] = headerValue;
    return this;
  }

  HttpGlobalConfig addParams(Map<String, dynamic> params) {
    this.params = params;
    return this;
  }

  HttpGlobalConfig addParam(String key, String value) {
    params[key] = value;
    return this;
  }

  HttpGlobalConfig isPrintLog(bool logPrint) {
    this.logPrint = logPrint;
    return this;
  }

  HttpGlobalConfig addInterceptor(dynamic interceptorsWrapper) {
    globalInterceptors.add(interceptorsWrapper);
    return this;
  }

  HttpGlobalConfig addInterceptors(List<dynamic> globalInterceptors) {
    this.globalInterceptors.addAll(globalInterceptors);
    return this;
  }

  HttpGlobalConfig setSSlFilePath(String sslFilePath) {
    _sslFilePath = sslFilePath;
    return this;
  }

  HttpGlobalConfig setHttpProxy(String httpProxy) {
    _httpProxy = httpProxy;
    return this;
  }

  //设置响应数据类型
  HttpGlobalConfig setResponseType(XResponseType xResponseType) {
    this.xResponseType = xResponseType;
    return this;
  }

  HttpGlobalConfig setBaseUrl(String baseUrl) {
    this.baseUrl = baseUrl;
    return this;
  }

  HttpGlobalConfig setRetryDelayMillis(int retryDelayMillis) {
    this.retryDelayMillis = retryDelayMillis;
    return this;
  }

  HttpGlobalConfig setRetryCount(int retryCount) {
    this.retryCount = retryCount;
    return this;
  }

  HttpGlobalConfig setReadTimeOut(int readTimeOut) {
    this.readTimeOut = readTimeOut;
    return this;
  }

  HttpGlobalConfig setWriteTimeOut(int writeTimeOut) {
    this.writeTimeOut = writeTimeOut;
    return this;
  }

  HttpGlobalConfig setConnectTimeOut(int connectTimeOut) {
    this.connectTimeOut = connectTimeOut;
    return this;
  }

}