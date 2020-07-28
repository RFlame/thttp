import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import 'package:thttp/src/request/dio_base_request.dart';
import 'package:thttp/src/mode/xhttp_response.dart';
import 'package:thttp/src/mode/xhttp_error.dart';

///
///    author : TaoTao
///    date   : 2020/3/9 5:41 PM
///    desc   : Dio 请求
///

/// Download请求类
class DownloadRequest extends DioBaseRequest<DownloadRequest> {
  String _savePath;
  XProgressCallback _zyProgressCallback;

  DownloadRequest(String suffixUrl, {XProgressCallback zyProgressCallback}) {
    this.suffixUrl = suffixUrl;
    _zyProgressCallback = zyProgressCallback;
    method = 'Download';
  }

  DownloadRequest savePath(String savePath) {
    _savePath = savePath;
    return this;
  }

  @override
  Future<XResponse> execute() async {
    XResponse zyResponse = XResponse();
    try {
      Dio dio = await configClient() as Dio;
      Response response = await dio.download(
          suffixUrl,
          _savePath,
          data: params,
      onReceiveProgress: _zyProgressCallback);
      zyResponse.data = response.data;
    } catch (e) {
      //TODO 统一处理错误
      zyResponse.httpError = XHttpError(1000, e.toString());
      return zyResponse;
    }
    return zyResponse;
  }
}

/// Upload请求类
class UploadRequest extends DioBaseRequest<UploadRequest> {
  XProgressCallback _zyProgressCallback;

  UploadRequest(String suffixUrl, {XProgressCallback zyProgressCallback}) {
    this.suffixUrl = suffixUrl;
    _zyProgressCallback = zyProgressCallback;
  }

  UploadRequest addFileByte(String key, List<int> bytes, String fileName) {
    if(bytes != null) {
      params[key] = MultipartFile.fromBytes(bytes, filename: fileName,);
    }
    return this;
  }

  ///TODO  目前dio需要传filename，暂时不提供此方法
  /*UploadRequest addFileBytes(String key, List<List<int>> bytesList) {
    List<MultipartFile> multipartFiles = [];
    if(bytesList != null && bytesList.isNotEmpty) {
      for(List<int> bytes in bytesList) {
        multipartFiles.add(MultipartFile.fromBytes(bytes));
      }
    }
    params[key] = multipartFiles;
    return this;
  }*/

  UploadRequest addFile(String key, File file) {
    if(file != null) {
      addFilePath(key, file.path);
    }
    return this;
  }

  UploadRequest addFiles(String key, List<File> files) {
    List<MultipartFile> multipartFiles = [];
    if(files != null && files.isNotEmpty) {
      for(File file in files) {
        multipartFiles.add(MultipartFile.fromFileSync(file.path));
      }
    }
    params[key] = multipartFiles;
    return this;
  }

  UploadRequest addFilePath(String key, String path) {
    if(path != null) {
      params[key] = MultipartFile.fromFileSync(path);
    }
    return this;
  }

  UploadRequest addFilePaths(String key, List<String> paths) {
    List<MultipartFile> multipartFiles = [];
    if(paths != null && paths.isNotEmpty) {
      for(String path in paths) {
        multipartFiles.add(MultipartFile.fromFileSync(path));
      }
    }
    params[key] = multipartFiles;
    return this;
  }

  @override
  Future<XResponse> execute() async{
    XResponse zyResponse = XResponse();
    try {
      FormData formData = FormData.fromMap(params);
      Dio dio = await configClient() as Dio;
      Response response = await dio.post(
          suffixUrl,
          data: formData,
          onSendProgress: _zyProgressCallback);
      zyResponse.data = response.data;
    } catch (e) {
      //TODO 统一处理错误
      zyResponse.httpError = XHttpError(1000, e.toString());
      return zyResponse;
    }
    return zyResponse;
  }
}