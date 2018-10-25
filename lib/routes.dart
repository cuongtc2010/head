import 'package:flutter/material.dart';
import 'package:head_phan_mem_panda/scoped_models/app_model.dart';

import 'screens/MainPage/main_page.dart';
import 'screens/Login/login.dart';

final AppModel _model = AppModel();
bool _isAuthenticated = false;

final routes = {
  '/': (BuildContext context)=>new LoginForm(),
  '/login': (BuildContext context)=>new LoginForm(),
  '/main-page': (BuildContext context)=>new MainPage(),
};