import 'package:thttp/src/mode/xhttp_response.dart';
///
///    author : TaoTao
///    date   : 2020/3/9 11:10 AM
///    desc   : 全局常量配置
///
class ZyConfig {

  static final String API_HOST = 'https//api.github.com';//默认API主机地址

  static final int DEFAULT_TIMEOUT = 60 * 1000;//默认超时时间
  static final int DEFAULT_RETRY_COUNT = 0;//默认重试次数
  static final int DEFAULT_RETRY_DELAY_MILLIS = 1000;//默认重试间隔时间

  static final String DEFAULT_DOWNLOAD_DIR = 'download';//默认下载目录
  static final String DEFAULT_DOWNLOAD_FILE_NAME = 'download_file.tmp';//默认下载文件名称

  static final XResponseType DEFAULT_ZY_RESPONSE_TYPE = XResponseType.json; //响应数据类型
}