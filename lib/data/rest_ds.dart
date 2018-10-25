/*
import 'dart:async';

import '../utils/network_util.dart';
import '../models/user/user.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://192.168.1.6";
  static final LOGIN_URL = BASE_URL + "/honda/mobile/web/index.php?r=login/login";
  static final _API_KEY = "somerandomkey";

  Future<User> login(String username, String password) {
    print("Vao toi day");
    return _netUtil.post(LOGIN_URL, body: {
      "username": username,
      "password": password
    }).then((dynamic res) {
      print(res.toString());
      if(res["error"]) throw new Exception(res["error_msg"]);
      return new User.map(res["user"]);
    });
  }
}*/
