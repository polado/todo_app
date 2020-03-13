import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import 'base_view.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T>
    implements BaseView {
  CancelFunc cancelFunc = null;
  bool _loaderVisiable = false;

  Widget buildWidget(BuildContext context);

  bool myInterceptor(bool stopDefaultButtonEvent) {
    return _loaderVisiable;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return buildWidget(context);
  }

  Future<dynamic> navigateTo(Widget screen) {
    return Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  void closeKeyboard() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  @override
  void showLoading({String msg = "Loading.."}) {
    closeKeyboard();
    cancelFunc?.call();

    cancelFunc = BotToast.showLoading();
    _loaderVisiable = true;
  }

  @override
  void hideLoading() {
    cancelFunc?.call();
    _loaderVisiable = false;
  }

  @override
  void showSuccessMsg(String msg) {
    if (msg == null || msg.isEmpty) return;

    showToast(msg, Icons.check_circle, Colors.green);
  }

  @override
  void showErrorMsg(String msg) {
    if (msg == null || msg.isEmpty) return;

    showToast(msg, Icons.error, Colors.red);
  }

  void showToast(String msg, IconData icon, Color color) {
    BotToast.showCustomText(
      duration: Duration(seconds: 2),
      onlyOne: true,
      align: Alignment(0, 0.8),
      toastBuilder: (_) => Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(horizontal: 12),
        clipBehavior: Clip.antiAlias,
        shape:
            RoundedRectangleBorder(borderRadius: new BorderRadius.circular(6)),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(icon, color: color),
              SizedBox(width: 16),
              Flexible(
                child: Text(
                  msg,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                      fontSize: 16, color: color, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
