import 'dart:convert';

import 'package:flutter/material.dart';
import '../MainPage/main_page.dart';
import 'package:head_phan_mem_panda/scoped_models/app_model.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm>
    with TickerProviderStateMixin{
  AnimationController _loginButtonController;
  var animationStatus = 0;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _loginButtonController = new AnimationController(
        duration: new Duration(milliseconds: 300), vsync: this);
  }

  @override
  void dispose() {
    _loginButtonController.dispose();
    super.dispose();
  }

  final Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
  };
  //LoginScreenPresenter _presenter;
  void _submit(AppModel model) async{
    final form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      //var result = user.checkLogin(new User(username: _username, password: _password));
      Map<String, dynamic> authResult = await model.checkLogin(_formData["username"], _formData["password"]);
      if(authResult["success"]){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      }else{
        ErrorDialog.show(context, "Sai tài khoản hoặc mật khẩu");
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    /* ---------------------------Start create login form--------------------------- */

    Widget _loginButton(AppModel model){
      return new ButtonTheme(
        height: 50.0,
        child: new Expanded(
          child: new RaisedButton(
              color: Colors.blue[700],
              textColor: Colors.white,
              shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              child: new Text(
                "Đăng nhập",
                textAlign: TextAlign.center,
              ),
              onPressed: () {
                _submit(model);
              }),
        ),
      );
    }
    var txtUsername = new Container(
      margin: EdgeInsets.only(top: 30.0),
      decoration: new BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: new TextFormField(
        decoration: InputDecoration(
            hintText: "Tên đăng nhập",
            contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
            border: InputBorder.none,
            icon: Icon(Icons.account_circle)),
        validator: (value) {
          if (value.isEmpty) {
            return 'Vui lòng nhập tài khoản!';
          }
        },
        onSaved: (val) => _formData["username"] = val,
      ),
    );
    var txtPassword = new Container(
      margin: EdgeInsets.only(top: 10.0),
      decoration: new BoxDecoration(
          color: const Color(0xFFF2F2F2),
          borderRadius: BorderRadius.all(Radius.circular(30.0))),
      child: new TextFormField(
        decoration: InputDecoration(
            hintText: "Mật khẩu",
            contentPadding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
            border: InputBorder.none,
            icon: Icon(Icons.lock_open)),
        validator: (value) {
          if (value.isEmpty) {
            return 'Vui lòng nhập mật khẩu!';
          }
        },
        obscureText: true,
        onSaved: (val) => _formData["password"] = val,
      ),
    );
    /*var loginForm = new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Form(
          key: _formKey,
          child: new SingleChildScrollView(
            child: new ConstrainedBox(
              constraints: new BoxConstraints(),
              child: new Column(
                children: <Widget>[
                  new FlutterLogo(
                    size: 150.0,
                  ),
                  txtUsername,
                  txtPassword
                ],
              ),
            ),
          ),
        ),
        new Container(
          height: 50.0,
          margin: EdgeInsets.only(top: 30.0),
          child: new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _isLoading ? new CircularProgressIndicator() : loginBtn
              ]),
        )
      ],
    );*/

    Widget _buildLoginForm(AppModel model){
      return Scaffold(
          key: _scaffoldKey,
          body: new Stack(
            alignment: Alignment(0.0, 0.0),
            fit: StackFit.expand,
            children: <Widget>[
              new Image(
                image: new AssetImage("images/2.jpg"),
                fit: BoxFit.cover,
                color: Colors.black38,
                colorBlendMode: BlendMode.darken,
              ),
              new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Form(
                    key: _formKey,
                    child: new SingleChildScrollView(
                      child: new ConstrainedBox(
                        constraints: new BoxConstraints(),
                        child: new Column(
                          children: <Widget>[
                            new FlutterLogo(
                              size: 150.0,
                            ),
                            txtUsername,
                            txtPassword
                          ],
                        ),

                      ),
                    ),
                  ),
                  new Container(
                    height: 50.0,
                    margin: EdgeInsets.only(top: 30.0),
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          model.isLoading ? new CircularProgressIndicator() : _loginButton(model)
                        ]),
                  )
                ],
              )
            ],
          )
      );
    }
    /* ---------------------------End create login form--------------------------- */
    return ScopedModelDescendant<AppModel>(
        builder: (BuildContext context, Widget child, AppModel model) {
          return _buildLoginForm(model);
        });
  }
}

class ErrorDialog {
  static void show(BuildContext context, [String message]) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Something went wrong'),
          content: Text(message != null ? message : 'Please try again!'),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text('Đóng'),
            )
          ],
        );
      },
    );
  }
}
