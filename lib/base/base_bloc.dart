import 'base_view.dart';

abstract class BaseBloc {
  BaseView view;

  BaseBloc(this.view);

  void handleError(dynamic e) {
    String msg;

    if (msg == null || msg.isEmpty) msg = "check internet";

    onError(msg);
  }

  void onError(String msg) {
    view?.hideLoading();
    view?.showErrorMsg(msg);
  }

  void onDispose();
}
