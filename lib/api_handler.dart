import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constant.dart';
import 'entity.dart';


class URL {
  static const String baseURL = 'https://ticket-new-dot-dobody-anvui.appspot.com/';
  static const String login = 'user/rlogin';
}

class ServerConnection {
  ServerConnection(this.url, this.body);

  final String url;
  final dynamic body;


  /// Lấy dữ liệu từ server theo methods GET
  Future<AVResponse> getData() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _url = URL.baseURL + url;
    final Map<String, String> headers = <String, String>{};
    headers[Constant.contentType] = 'application/json';
    headers[Constant.headerDOBODY6969] = prefs.getString(Constant.token).toString();

    print('Calling get data ===============================================');
    print('header: ' + headers.toString());
    print('URL: ' + url);
    try {
      final Response response = await get(_url, headers: headers).timeout(const Duration(seconds: 30));
      if (response != null) {
        print('response: ' + response.body);
      }
      AVResponse result;
      if (_statusOk(response.statusCode)) {
        result = AVResponse(
          code: response.statusCode,
          ok: true,
          response: jsonDecode(response.body)[Constant.results] as Map<String, dynamic>,
        );
      } else {
        final Map<String, dynamic> jsonError =
            jsonDecode(response.body)[Constant.results][Constant.error] as Map<String, dynamic>;
        result = AVResponse(
          ok: false,
          code: response.statusCode,
          response: jsonError,
          message: getErrorMessage(getInt(Constant.code, jsonError)),
        );
      }
      return result;
    } on TimeoutException catch (timeOutError) {
      print('API Timeout ${timeOutError.message}');
      throw APIException(AVResponse(
        ok: false,
        code: 408,
        response: <String, dynamic>{},
        message: getErrorMessage(408),
      ));
    } catch (error) {
      print('API Exception $error');
      throw APIException(AVResponse(
        ok: false,
        code: 100,
        response: <String, dynamic>{},
        message: getErrorMessage(100),
      ));
    }
  }

  /// Lấy dữ liệu từ server theo methods POST
  Future<AVResponse> postData({Map<String, String> header}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _url = URL.baseURL + url;
    Map<String, String> headers = <String, String>{};
    if (header != null) {
      headers = header;
    } else {
      headers[Constant.contentType] = 'application/json';
      headers[Constant.headerDOBODY6969] = prefs.getString(Constant.token).toString();
    }
    if (body is List) {
      body.forEach((dynamic item) {
        item[Constant.packageName] = 'vn.anvui.ticketsales';
        item[Constant.timeZone] = 7;
        item[Constant.platform] = 1;
        item[Constant.deviceType] = 1;
        item[Constant.companyId] = prefs.getString(Constant.companyId);
        item[Constant.fcmToken] = prefs.getString(Constant.firebaseKey);
        item[Constant.deviceId] = prefs.getString(Constant.firebaseKey);
      });
    } else {
      body[Constant.packageName] = 'vn.anvui.ticketsales';
      body[Constant.timeZone] = 7;
      body[Constant.platform] = 1;
      body[Constant.deviceType] = 1;
      body[Constant.companyId] = prefs.getString(Constant.companyId);
      body[Constant.fcmToken] = prefs.getString(Constant.firebaseKey);
      body[Constant.deviceId] = prefs.getString(Constant.firebaseKey);
    }

    print('Calling post data ===============================================');
    print('header: ' + headers.toString());
    print('URL: ' + url);
    print('body: ' + json.encode(body));
    try {
      final Response response =
          await post(_url, headers: headers, body: jsonEncode(body)).timeout(const Duration(seconds: 30));
      if (response != null) {
        print('response: ' + response.body);
      }
      AVResponse result;
      if (_statusOk(response.statusCode)) {
        result = AVResponse(
          code: response.statusCode,
          ok: true,
          response: json.decode(response.body)[Constant.results] as Map<String, dynamic>,
        );
      } else {
        final Map<String, dynamic> jsonError =
            json.decode(response.body)[Constant.results][Constant.error] as Map<String, dynamic>;
        result = AVResponse(
          ok: false,
          code: response.statusCode,
          response: jsonError,
          message: getErrorMessage(getInt(Constant.code, jsonError)),
        );
      }
      return result;
    } on TimeoutException catch (timeOutError) {
      print('API Timeout ${timeOutError.message}');
      throw APIException(AVResponse(
        ok: false,
        code: 408,
        response: <String, dynamic>{},
        message: getErrorMessage(408),
      ));
    } catch (error) {
      print('API Exception $error');
      throw APIException(AVResponse(
        ok: false,
        code: 100,
        response: <String, dynamic>{},
        message: getErrorMessage(100),
      ));
    }
  }

  /// API để upload ảnh lên server
  Future<StreamedResponse> uploadImage(File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String _url = URL.baseURL + url;
    final Map<String, String> headers = <String, String>{};
    headers[Constant.contentType] = 'multipart/form-data';
    headers[Constant.headerDOBODY6969] = prefs.getString(Constant.token).toString();

    print('Calling upload image ===========================================');
    print('header: ' + headers.toString());
    print('URL: ' + url);
    print('body: ' + json.encode(body).toString());

    final Uri uri = Uri.parse(_url);
    final ByteStream stream = ByteStream(Stream.castFrom(file.openRead()));
    final int length = await file.length();

    final MultipartRequest request = MultipartRequest('POST', uri);
    final MultipartFile multipartFile = MultipartFile(
      'file',
      stream,
      length,
      filename: basename(file.path),
    );
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    print('request' + request.headers.toString());
    final StreamedResponse response = await request.send();
    print(response.statusCode);

    return response;
  }

  bool _statusOk(int statusCode) {
    return statusCode >= 200 && statusCode <= 300;
  }
}

/// Lấy string lỗi theo mã
String getErrorMessage(int code) {
  switch (code) {
    case 108:
      return 'Tên đăng nhập hoặc mật khẩu không chính xác.';
    case 103:
      return 'Có lỗi xảy ra, vui lòng thử lại';
    case 122:
      return 'Sai tên đăng nhập hoặc mật khẩu';
    case 100:
      return 'Mất kết nối mạng.';
    case 107:
      return 'Bạn không có quyền thực hiện chức năng này';
    case 104:
      return 'Ghế đã có người đặt';
    case 110:
      return 'Ảnh không thể trống';
    case 408:
      return 'Không thể kết nối đến Server. Vui lòng kiểm trả kết nối mạng.';
    default:
      return 'Mất kết nối mạng. Vui lòng kiểm tra lại.';
  }
}

class APIException implements Exception {
  APIException(this.aVResponse);

  final AVResponse aVResponse;

  String message() {
    return aVResponse.message;
  }
}

@JsonSerializable(nullable: false)
class AVResponse {
  AVResponse({
    @required this.ok,
    @required this.code,
    @required this.response,
    this.message,
  }); // case not ok show message

  final bool ok; // check Response is OK
  final int code; // status code
  final Map<String, dynamic> response; // data body response
  final String message;

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      Constant.ok: ok,
      Constant.code: code,
      Constant.response: response,
      Constant.message: message,
    };
  }

}


class APIParse {
  static String listToString(String key, List<dynamic> values) {
    String request = '';
    for (final dynamic item in values) {
      request += '$key=$item&';
    }
    print('request $request');
    return request;
  }
}
