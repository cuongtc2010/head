import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import '../models/config/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user/user.dart';
import '../models/lichsumuaxe/lich_su_mua_xe.dart';
import 'package:rxdart/subjects.dart';

class CoreModel extends Model {
  bool _isLoading = false;
  User _user;
  List<LichSuMuaXe> _lichsumuaxes = [];
  List<LichSuMuaXe> _lichsuChiTiet = [];
}

class UserModel extends CoreModel {
  PublishSubject<bool> _userSubject = PublishSubject();

  bool get isLoading {
    return _isLoading;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }

  Future<Map<String, dynamic>> checkLogin(
      String username, String password) async {
    _isLoading = true;
    notifyListeners();

    final Map<String, dynamic> formData = {
      'username': username,
      'password': password,
    };
    try {
      final http.Response response = await http.post(LOGIN_URL,
          body: json.encode(formData),
          headers: {'Content-Type': 'application/json'});
      final Map<String, dynamic> mapResponse = json.decode(response.body);
      if (mapResponse["status"] == 201) {
        print(mapResponse);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("token", mapResponse["data"]["token"]);
        await prefs.setString(
            "username", mapResponse["data"]["profile"]["username"]);

        if (prefs.getString('token') != null) {
          _user = User(
            username: prefs.getString('username'),
            token: prefs.getString('token'),
          );
        }
        _userSubject.add(true);
        _isLoading = false;
        notifyListeners();
        return {"success": true};
      } else {
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
    } catch (error) {
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

class LichSuMuaXeModel extends CoreModel {
  List<LichSuMuaXe> get lichsumuaxes {
    return List.from(_lichsumuaxes);
  }

  List<LichSuMuaXe> get lichsuChiTiet {
    return List.from(_lichsuChiTiet);
  }

  User get user {
    return _user;
  }

  Future getListLichSu() async {
    _isLoading = true;
    notifyListeners();

    try {
      final http.Response response = await http.get(List_Lich_Su, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + _user.token
      });

      if (response.statusCode != 200) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final Map<String, dynamic> getReponseLichSu = json.decode(response.body);

      if (getReponseLichSu == null) {
        _isLoading = false;
        notifyListeners();

        return;
      }

      try {
        final lichsus = getReponseLichSu["data"].cast<Map<String, dynamic>>();
        _lichsumuaxes = await lichsus.map<LichSuMuaXe>((json) {
          return LichSuMuaXe.fromJson(json);
        }).toList();
      } catch (e) {
        print(e.toString());
      }

      /*listLichSu["data"].forEach((listData){
        final LichSuMuaXe valueLichSu = LichSuMuaXe(
            id: listData["id"],
            id_dong_bo_phan_mem: listData["id_dong_bo_phan_mem"],
            ngay: listData["ngay"],
            tu_ngay: listData["tu_ngay"],
            den_ngay: listData["den_ngay"],
            phan_loai_noi_dung: listData["phan_loai_noi_dung"],
            id_khach_hang: listData["id_khach_hang"],
            ghi_chu: listData["ghi_chu"],
            noi_dung_tong_quat: listData["noi_dung_tong_quat"],
            noi_dung_chi_tiet: listData["noi_dung_chi_tiet"],
        );
        _lichsumuaxes.add(valueLichSu);
      });*/

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future getLichSuChiTiet(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final http.Response response =
          await http.get(Chi_Tiet_Lich_Su + id, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + prefs.getString('token')
      });

      if (response.statusCode != 200) {
        _isLoading = false;
        notifyListeners();
        return;
      }

      final Map<String, dynamic> getReponseLichSuChiTiet =
          await json.decode(response.body);

      if (getReponseLichSuChiTiet == null) {
        _isLoading = false;
        notifyListeners();

        return;
      }

      try {
        final lichsus = getReponseLichSuChiTiet["data"].cast<Map<String, dynamic>>();
        _lichsumuaxes = await lichsus.map<LichSuMuaXe>((json) {
          return LichSuMuaXe.fromJson(json);
        }).toList();
      } catch (e) {
        print("GG: " + e.toString());
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      print(e);
      _isLoading = false;
      notifyListeners();
    }
    return;
  }
}
