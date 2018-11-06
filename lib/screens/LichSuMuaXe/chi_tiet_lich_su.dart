import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';
import '../../scoped_models/app_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/lichsumuaxe/lich_su_mua_xe.dart';

class ChiTietLichSuScreen extends StatefulWidget {
  final String lichsuId;

  ChiTietLichSuScreen({this.lichsuId}) : super();

  @override
  State<StatefulWidget> createState() {
    return ChiTietlichSuState();
  }
}

class ChiTietlichSuState extends State<ChiTietLichSuScreen> {
  final AppModel _model = AppModel();

  @override
  void initState() {
    _model.getLichSuChiTiet(widget.lichsuId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget cardChiTiet(AppModel model) {
      return Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text("Lịch sử Id: "),
                Text(model.lichsumuaxes[0].id),
              ],
            ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            ),
            HtmlView(
              data: model.lichsumuaxes[0].noi_dung_tong_quat,
            ),
            Divider(
              height: 2.0,
              color: Colors.grey,
            )
          ],
        ),
      );
    }

    return ScopedModel<AppModel>(
      model: _model,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết giao dịch"),
        ),
        body: ScopedModelDescendant<AppModel>(
          builder: (BuildContext context, Widget child, AppModel model) {
            return cardChiTiet(model);
          },
        ),
      ),
    );
  }
}
