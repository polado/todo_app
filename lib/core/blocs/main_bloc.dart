import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/base/base_bloc.dart';
import 'package:todo_app/base/base_view.dart';

class MainBloc extends BaseBloc {
  Stream<FirebaseUser> mainController =
      FirebaseAuth.instance.onAuthStateChanged;

  MainBloc(BaseView view) : super(view);

  @override
  void onDispose() {}
}
