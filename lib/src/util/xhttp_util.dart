import 'package:dio/dio.dart';
import 'package:thttp/src/mode/xhttp_response.dart';

///
///    author : TaoTao
///    date   : 2020/3/9 3:07 PM
///    desc   : 工具类
///
class DioHttpUtil {

  static ResponseType getDioResponseType(XResponseType zyResponseType) {
    ResponseType responseType = ResponseType.json;
    if(zyResponseType == null) {
      return responseType;
    }
    if(zyResponseType == XResponseType.json) {
      responseType = ResponseType.json;
    } else if(zyResponseType == XResponseType.bytes) {
      responseType = ResponseType.bytes;
    } else if(zyResponseType == XResponseType.plain) {
      responseType = ResponseType.plain;
    } else if(zyResponseType == XResponseType.stream) {
      responseType = ResponseType.stream;
    }
    return responseType;
  }
}