import 'package:thttp/src/http_config.dart';
import 'package:thttp/src/request/zyhttp_request.dart';
import 'package:thttp/src/request/dio_request.dart';
import 'package:thttp/src/mode/xhttp_response.dart';

///
///    author : TaoTao
///    date   : 2020/3/6 11:05 AM
///    desc   : 网路库外部调用类
///
class THttp {

  static HttpGlobalConfig _httpGlobalConfig = HttpGlobalConfig.singleton;

  static HttpGlobalConfig config() => _httpGlobalConfig;

  static init() {
  }

  ///GET请求
  static GetRequest get(String suffixUrl) {
    return GetRequest(suffixUrl);
  }

  ///POST请求
  static PostRequest post(String suffixUrl) {
    return PostRequest(suffixUrl);
  }

  ///HEAD请求
  static HeadRequest head(String suffixUrl) {
    return HeadRequest(suffixUrl);
  }

  ///PUT请求
  static PutRequest put(String suffixUrl) {
    return PutRequest(suffixUrl);
  }

  ///PATCH请求
  static PatchRequest patch(String suffixUrl) {
    return PatchRequest(suffixUrl);
  }

  ///DELETE请求
  static DeleteRequest delete(String suffixUrl) {
    return DeleteRequest(suffixUrl);
  }

  ///上传
  static UploadRequest upload(String suffixUrl, {XProgressCallback xProgressCallback}) {
    return UploadRequest(suffixUrl, zyProgressCallback: xProgressCallback);
  }

  ///下载
  static DownloadRequest download(String suffixUrl, {XProgressCallback xProgressCallback}) {
    return DownloadRequest(suffixUrl, zyProgressCallback: xProgressCallback);
  }

}