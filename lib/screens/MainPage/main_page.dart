import 'package:flutter/material.dart';
import '../Home/home.dart';
import '../LichSuMuaXe/lich_su_mua_xe.dart';
import '../KhuyenMai/khuyen_mai.dart';
import '../ThongTin/thong_tin.dart';
import '../../widgets/logout_dialog.dart';
import '../../models/user/user.dart';
import 'package:flutter/services.dart';
import 'package:head_phan_mem_panda/scoped_models/app_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../LichSu/lich_su.dart';


class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new MainPageState();
  }
}

class MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollViewController;
  var title = '';
  final AppModel model = AppModel();
  Widget _buildDrawer(context, AppModel model) {
    return new Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          new DrawerHeader(
            child: new Container(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    child: new CircleAvatar(
                      child: new ClipOval(
                        child: new Image.asset('images/2.jpg',
                            width: 80.0, height: 80.0, fit: BoxFit.cover),
                      ),
                    ),
                    width: 80.0,
                    height: 80.0,
                  ),
                  new Text(
                    'Phạm Cường',
                    style: new TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                  new Text('Developer',
                      style: new TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0))
                ],
              ),
            ),
            decoration: new BoxDecoration(color: Colors.blue),
          ),
          new ListTile(
            leading: new Icon(Icons.home),
            title: new Text("Trang chủ"),
            onTap: () async {
              try{
                print(model.user.token);
              }catch(e){
                print(e.toString());
              }
              await new Home();
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.bookmark),
            title: new Text("Lịch bảo dưỡng"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.card_giftcard),
            title: new Text("Chương trình khuyến mãi"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          new Divider(
            color: Colors.black45,
          ),
          new ListTile(
            leading: new Icon(Icons.account_box),
            title: new Text("Tài khoản"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          new ListTile(
            leading: new Icon(Icons.power_settings_new),
            title: new Text("Đăng xuất"),
            onTap: () async {
              Navigator.of(context).pop();
              bool confirm = await LogoutConfirmDialog.show(context);
              if (confirm) {
                model.logout();
              }
            },
          ),
          new Divider(
            color: Colors.black45,
          ),
          new ListTile(
            title: new Text(
              "Trợ giúp và phản hồi",
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          new ListTile(
            title: new Text(
              "Giới thiệu",
              style: new TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollViewController = new ScrollController();
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppModel>(
      builder: (BuildContext context, Widget child, AppModel model){
        return new Scaffold(
          body: new NestedScrollView(
              controller: _scrollViewController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  new SliverAppBar(
                    title: new Text("Phần mềm panda head"),
                    pinned: true,
                    floating: true,
                    forceElevated: innerBoxIsScrolled,
                    bottom: new TabBar(
                      indicatorColor: Colors.white,
                      tabs: [
                        new Tab(icon: new Icon(Icons.home), text: "Home"),
                        new Tab(icon: new Icon(Icons.bookmark), text: "Mua xe"),
                        //new Tab(icon: new Icon(Icons.gif), text: "Khuyến mãi"),
                        //new Tab(icon: new Icon(Icons.list), text: "Thông tin")
                        //new Tab(icon: new Icon(Icons.list), text: "Nhân viên")

                      ],
                      controller: _tabController,
                    ),
                  )
                ];
              },
              body: new TabBarView(
                children: [
                  new Home(),
                  new LichSuMuaXeScreen(model),
                  //new KhuyenMai(),
                  //new ThongTin()
                  //new UserScreen()
                ],
                controller: _tabController,
              )),
          drawer: _buildDrawer(context, model),
        );
      },
    );
  }
}
