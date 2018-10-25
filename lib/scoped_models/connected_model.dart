import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import '../models/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user/user.dart';
import 'package:rxdart/subjects.dart';

class CoreModel extends Model {
  bool _isLoading = false;
  User _user;
}
class UserModel extends CoreModel {
  PublishSubject<bool> _userSubject = PublishSubject();

  User get user {
    return _user;
  }

  bool get isLoading {
    return _isLoading;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> checkLogin(String username, String password) async {

    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> formData = {
      'username': username,
      'password': password,
    };
    try{
      final http.Response response = await http.post(LOGIN_URL,
          body: json.encode(formData),
          headers: {'Content-Type': 'application/json'});
      final Map<String, dynamic> mapResponse = json.decode(response.body);
      if(mapResponse["status"] == 201){
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("token", mapResponse["data"]["token"]);
        prefs.setString("username", mapResponse["data"]["profile"]["username"]);
        _userSubject.add(true);
        _isLoading = false;
        notifyListeners();
        return {"success": true};
      }else{
        _isLoading = false;
        notifyListeners();
        return {"success": false, "errors": mapResponse["errors"]};
      }

      /*if (response.statusCode == 200) {
      if (mapResponse["status"] == 404) {
        print(mapResponse["errors"]["password"]);
        return mapResponse;
      }
      if (mapResponse["status"] == 201) {
        print(mapResponse["data"]);
        return mapResponse;
      } else {
        return mapResponse;
      }
    }else{
      throw Exception("Lỗi server");
    }*/
    }catch(error){
      _isLoading = false;
      notifyListeners();

      return {'success': false, 'message': error};
    }
  }

  void logout() async {
    _user = null;

    _userSubject.add(false);

    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoAuthentication() async {
    final prefs = await SharedPreferences.getInstance();
    final String token = prefs.getString('token');

    if (token != null) {
      _user = User(
        username: prefs.getString('username'),
        token: token,
      );
      _userSubject.add(true);
      notifyListeners();
    }
  }
}
