import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thttp/thttp.dart';
import 'package:thttp_example/record.dart';
import 'package:thttp_example/test_custom_interceptor.dart';

import 'base_mode.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController _controllerPhone = TextEditingController();
  TextEditingController _controllerCode = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initState();
  }

  Map<String, dynamic> myHeaders = {
    "Accept" : "application/json; charset=UTF-8"
  };
  String baseUrl = 'http://47.110.156.130:8815';
  String token;
  int uid;
  _initState() async{
    THttp.init();
    THttp
        .config()
        .isPrintLog(true)
        .setBaseUrl(baseUrl)
        .addHeaders(myHeaders)
//        .setSSlFilePath('assets/https/rootcert.pem')
        .setConnectTimeOut(30 * 1000);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              MaterialButton(
                  onPressed: _post,
                  child: Text('post')),
              MaterialButton(
                  onPressed: _get,
                  child: Text('get')),
            ],
          ),
        ),
      ),
    );
  }

  Record _record;
  _post() async {
    XResponse xResponse =
    await THttp
        .post('/api/createRecord')
        .addParam('title', '我的一条记录')
        .setResponseType(XResponseType.json)
        .addInterceptor(TestCustomInterceptor())
        .request();
    BaseResponse baseResponse = BaseResponse.fromJson(xResponse.data);
    if(baseResponse?.isSuccess == true) {
      _record = Record.map(baseResponse.data);
    }
  }

  _get() async{
    await THttp
        .get('/api/getAllChildrenRecords')
        .addParam('parentId', _record?.parentId)
        .addInterceptor(TestCustomInterceptor())
        .request();
  }
  
  _downloadByZyHttp() async {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    print('tmpPath:$tempPath');
    THttp.download('16891/1A8EA15110A5DA113EBD2F955615C7EC.apk?fsname=com.moji.mjweather_7.0103.02_7010302.apk',
        xProgressCallback: (received, total){
          if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
          }
        })
        .savePath('$tempPath/download.apk')
        .setBaseUrl('http://imtt.dd.qq.com/')
        .request();
  }
  _downloadByDio() async {
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    print('tmpPath:$tempPath');
    Dio dio = Dio();
    dio.download('http://imtt.dd.qq.com/16891/1A8EA15110A5DA113EBD2F955615C7EC.apk?fsname=com.moji.mjweather_7.0103.02_7010302.apk',
        '$tempPath/download.apk',
      onReceiveProgress: (received, total) {
        if (total != -1) {
            print((received / total * 100).toStringAsFixed(0) + "%");
        }
      }
    );
  }

  _uploadByZyHttp() async{
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    Directory tempDir = await getExternalStorageDirectory();
    String tempPath = tempDir.path;
    ///上传图片路径uploadPath:/storage/emulated/0/Android/data/com.zyhealth.zyhttp_flutter_example/files/test.jpg
    String uploadPath = '$tempPath/test.jpg';
    print('uploadPath:$uploadPath');
    var bytes = await File(uploadPath).readAsBytes();
    THttp.upload('api/user/1.0/upload_avatar',
        xProgressCallback: (int sent, int total) {
          print('upload sent:$sent, total:$total');
        })
      .addHeader('action', 'upload-avatar')
      .addHeader('APP-VERSION', '1.0.1')
      .addHeader('token', '6A0DB7A683DB4E9EB76AE86EA88F3F09')
      .addParam('uid', '1902495')
//      .addFile('avatar', File(uploadPath))
      .addFileByte('avatar', bytes, 'avatar.jpg')
      .request();
  }
  
}
