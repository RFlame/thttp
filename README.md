# thttp_flutter

一个Flutter版本的网络中间件，内部默认使用网络库Dio。

- 项目依赖：

```
thttp:
  git:
    url: https://github.com/RFlame/thttp.git

import 'package:thttp/thttp.dart';
```

## 功能简介

- 支持get、post等请求方式，无需上层分别定义接口；

- 内部默认使用dio网路库，对上层透明，可无缝替换网络库；

- 支持全局配置、局部配置，局部配置可局部生效；

- 可设置响应参数类型，支持json、plain、stream、bytes；

- 支持单文件和多文件上传，可监听上传进度；

- 支持文件下载，可监听下载进度；

## 使用说明

### 全局配置

```
THttp
    .config()
    .isPrintLog(true)///日志开关
    .setBaseUrl(preBaseUrl)///设置基础域名
    .addHeaders(myHeaders)///设置全局头部信息
    .addParam("uid", "-1000")//设置全局参数
    .setSSlFilePath('assets/https/rootcert.pem')///设置证书路径
    .setConnectTimeOut(30 * 1000);///设置连接超时时间
```
### 发起请求

#### get

```
XResponse xResponse = await ZyHttp
          .get("api/user/1.0/login")
          .addHeader("ACTION", "login")
          .addParam("mobile", phone)
          .addParam("type", type)
          .addParam("verifyCode", "1234")
          .request();

//由于flutter不支持反射，目前json解析为bean放到放到业务层自己处理
BaseResponse baseResponse = BaseResponse.fromJson(xResponse.data);
```

#### post

```
XResponse xResponse = await THttp
          .post("api/user/1.0/login")
          .addHeader("ACTION", "login")
          .addParam("mobile", phone)
          .addParam("type", type)
          .addParam("verifyCode", "1234")
          .request();

//由于flutter不支持反射，目前json解析为bean放到放到业务层自己处理
BaseResponse baseResponse = BaseResponse.fromJson(xResponse.data);
```

#### download

```
THttp.download('16891/1A8EA15110A5DA113EBD2F955615C7EC.apk?fsname=com.moji.mjweather_7.0103.02_7010302.apk',
        xProgressCallback: (received, total){
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
        })
        .savePath('$tempPath/download.apk')
        .setBaseUrl('http://imtt.dd.qq.com/')
        .request();
```

#### upload

```
THttp.upload('api/user/1.0/upload_avatar',
        xProgressCallback: (int sent, int total) {
          print('upload sent:$sent, total:$total');
        })
      .addHeader('action', 'upload-avatar')
      .addHeader('APP-VERSION', '1.0.1')
      .addHeader('token', token.toString())
      .addParam('uid', uid.toString())
      .addFile('avatar', File(uploadPath))///支持传文件或者文件地址
      .request();
```

#### 多文件上传

```
THttp.upload('api/user/1.0/upload_avatar',
        xProgressCallback: (int sent, int total) {
          print('upload sent:$sent, total:$total');
        })
      .addHeader('action', 'upload-avatar')
      .addHeader('APP-VERSION', '1.0.1')
      .addHeader('token', token.toString())
      .addParam('uid', uid.toString())
      .addFiles('avatar', [File(uploadPath1), File(uploadPath2)])///支持传文件或者文件地址
      .request();
```

#### 设置响应数据格式、添加自定义拦截器

```
await THttp
          .post('api/user/1.0/security_check')
          .addParam('mobile', phone)
          .addParam('type', type)
          .setResponseType(xResponseType.json)
          .addInterceptor(CustomInterceptor())
          .request();
```

