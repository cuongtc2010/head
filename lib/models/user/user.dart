import 'dart:async';
import 'dart:convert';
import '../config/config.dart';
import 'package:http/http.dart' as http;

class User {
  String username;
  String password;
  String token;
  User({this.username, this.password, this.token});
}
