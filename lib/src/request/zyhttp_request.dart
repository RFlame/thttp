import 'package:thttp/src/request/dio_base_request.dart';
///
///    author : TaoTao
///    date   : 2020/3/9 2:31 PM
///    desc   : 网络请求类
///
/// Post请求类
class PostRequest extends DioBaseRequest<PostRequest> {
  PostRequest(suffixUrl) {
    this.suffixUrl = suffixUrl;
    this.method = 'Post';
  }
}

/// Get请求类
class GetRequest extends DioBaseRequest<GetRequest> {
  GetRequest(String suffixUrl) {
    this.suffixUrl = suffixUrl;
    method = 'Get';
  }
}

/// Put请求类
class PutRequest extends DioBaseRequest<PutRequest> {
  PutRequest(String suffixUrl) {
    this.suffixUrl = suffixUrl;
    method = 'Put';
  }
}

/// Patch请求类
class PatchRequest extends DioBaseRequest<PatchRequest> {
  PatchRequest(String suffixUrl) {
    this.suffixUrl = suffixUrl;
    method = 'Patch';
  }
}

/// Delete请求类
class DeleteRequest extends DioBaseRequest<DeleteRequest> {
  DeleteRequest(String suffixUrl) {
    this.suffixUrl = suffixUrl;
    method = 'Delete';
  }
}

/// Head请求类
class HeadRequest extends DioBaseRequest<HeadRequest> {
  HeadRequest(String suffixUrl) {
    this.suffixUrl = suffixUrl;
    method = 'Head';
  }
}


