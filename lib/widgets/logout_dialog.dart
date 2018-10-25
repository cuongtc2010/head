import 'package:flutter/material.dart';
import 'package:head_phan_mem_panda/scoped_models/app_model.dart';

class LogoutConfirmDialog {
  static Future<bool> show(BuildContext context, [String title]) async {
    final AppModel _model = new AppModel();
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title != null ? title : 'Bạn có muốn đăng xuất?'),
          contentPadding: EdgeInsets.all(10.0),
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  textColor: Colors.white,
                  color: Colors.red,
                  child: Text('Hủy'),
                  onPressed: (){
                    Navigator.pop(context, false);
                  },
                ),
                Padding(padding: EdgeInsets.only(right: 10.0),),
                FlatButton(
                  textColor: Colors.white,
                  color: Colors.green,
                  child: Text('OK'),
                  onPressed: (){
                    Navigator.pop(context, true);
                  },
                )
              ],
            ),
          ],
        );
      },
    );
  }
}