///
///    author : TaoTao
///    date   : 2020/3/6 3:24 PM
///    desc   :
///
class BaseResponse {
  int code;
  Map<String, dynamic> data;
  String msg;

  BaseResponse({
    this.code,
    this.data,
    this.msg,
  });

  get isSuccess => code == 1000;

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
      code: json["code"],
      data: json.containsKey('data') ? json['data'] : {},
      msg: json['msg']
  );

}
