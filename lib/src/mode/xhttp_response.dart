import 'dart:typed_data';

import 'package:thttp/src/mode/xhttp_error.dart';
///
///    author : TaoTao
///    date   : 2020/3/6 12:02 PM
///    desc   : 返回数据模型
///
class XResponse<T> {
  T data;
  List<int> bytesData;
  XHttpError httpError;

  /// The response stream
  Stream<Uint8List> stream;
}

enum XResponseType {
  /// Transform the response data to JSON object only when the
  /// content-type of response is "application/json" .
  json,

  /// Get the response stream without any transformation. The
  /// Response data will be a `ResponseBody` instance.
  ///
  ///    Response<ResponseBody> rs = await Dio().get<ResponseBody>(
  ///      url,
  ///      options: Options(
  ///        responseType: ResponseType.stream,
  ///      ),
  ///    );
  stream,

  /// Transform the response data to a String encoded with UTF8.
  plain,

  /// Get original bytes, the type of [Response.data] will be List<int>
  bytes
}

typedef XProgressCallback = void Function(int count, int total);