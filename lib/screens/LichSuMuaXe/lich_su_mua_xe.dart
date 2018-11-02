import 'package:flutter/material.dart';
import 'package:head_phan_mem_panda/scoped_models/app_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import '../../models/lichsumuaxe/lich_su_mua_xe.dart';
import 'chi_tiet_lich_su.dart';

class LichSuMuaXeScreen extends StatefulWidget {
  final AppModel model;
  
  LichSuMuaXeScreen(this.model);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LichSuMuaXeScreenState();
  }
}

class LichSuMuaXeScreenState extends State<LichSuMuaXeScreen> {
  @override
  void initState() {
    widget.model.getListLichSu();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Widget _listLichSuMuaXe(AppModel model) {
      return ListView.builder(
        padding: const EdgeInsets.only(top:16.0, bottom: 16.0),
        itemBuilder: (context, index) {
          return GestureDetector(
            child: new Card(
              child: Padding(
                padding: EdgeInsets.only(right: 10.0, left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new HtmlView(data: model.lichsumuaxes[index].noi_dung_chi_tiet),
                  ],
                ),
              ),
            ),
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChiTietLichSuScreen(lichsuId: model.lichsumuaxes[index].id)));
              //Navigator.pushNamed(context, '/chi-tiet-lich-su');
            },
          );
        },
        itemCount: model.lichsumuaxes.length,
      );
    }

    return ScopedModelDescendant<AppModel>(
        builder: (BuildContext context, Widget child, AppModel model) {
      return model.isLoading == false
          ? _listLichSuMuaXe(model)
          : Center(child: CircularProgressIndicator()
      );
    });
  }
}
