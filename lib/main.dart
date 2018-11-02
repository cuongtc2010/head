import 'package:flutter/material.dart';
import 'screens/Login/login.dart';
import 'screens/MainPage/main_page.dart';
import 'screens/LichSuMuaXe/chi_tiet_lich_su.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:head_phan_mem_panda/scoped_models/app_model.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  final AppModel _model = AppModel();
  bool _isAuthenticated = false;

  @override
  void initState() {
    _model.autoAuthentication();
    _model.userSubject.listen((bool isAuthenticated){
      setState(() {
        _isAuthenticated = isAuthenticated;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel<AppModel>(
      model: _model,
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "",
        //home: new LoginForm(),
        routes: {
          '/': (BuildContext context)=>_isAuthenticated ? MainPage() : new LoginForm(),
          '/login': (BuildContext context)=>_isAuthenticated ? MainPage() : new LoginForm(),
          '/main-page': (BuildContext context)=>_isAuthenticated ? new MainPage() : new LoginForm(),
          '/chi-tiet-lich-su': (BuildContext context)=>_isAuthenticated ? new ChiTietLichSuScreen() : new LoginForm(),
        },
        onUnknownRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            builder: (BuildContext context) =>
            _isAuthenticated ? MainPage() : LoginForm(),
          );
        },
      ),
    );
  }
}
