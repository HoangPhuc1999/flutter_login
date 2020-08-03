import 'dart:convert';
import 'package:flutterlogin/api_handler.dart';
import 'package:flutterlogin/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'entity.dart';

class UserRepository {

  Future<void> login(String user, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final Map<String, dynamic> map = <String, dynamic>{};
    map[Constant.userName] = user;
    map[Constant.password] = password;

    final AVResponse response =
        await ServerConnection(URL.login, map).postData();
    if (response.ok) {
      final Map<String, dynamic> jsonResult = response.response;
      prefs.setString(Constant.userInfo, jsonEncode(user));
      prefs.setString(
          Constant.refreshKey,
          getString(Constant.refreshKey,
              response.response[Constant.token] as Map<String, dynamic>));
      prefs.setString(
          Constant.userId,
          getString(Constant.id,
              response.response[Constant.userInfo] as Map<String, dynamic>));
      prefs.setString(
          Constant.fullName,
          getString(Constant.id,
              response.response[Constant.fullName] as Map<String, dynamic>));
      prefs.setString(
          Constant.token,
          getString(Constant.tokenKey,
              response.response[Constant.token] as Map<String, dynamic>));
      prefs.setString(
          Constant.company, json.encode(jsonResult[Constant.company]));
      prefs.setString(
          Constant.companyId,
          getString(Constant.companyId,
              jsonResult[Constant.company] as Map<String, dynamic>));
      return;
    } else {
      throw APIException(response);
    }
  }
}
