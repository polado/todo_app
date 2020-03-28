import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/base/base_bloc.dart';
import 'package:todo_app/base/base_view.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/user_model.dart';

class RegisterBloc extends BaseBloc {
  FirebaseUser firebaseUser;
  BaseView view;

  RegisterBloc(this.view) : super(view);

  Future<bool> getUserData() async {
    try {
      var snapshot = await Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .get();
      AppCache().setUser(UserModel(snapshot));
      return true;
    } catch (e) {
      print('errorss $e');
      return false;
    }
  }

  Future<bool> emailPasswordLogin(String email, String password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      firebaseUser = user;
      AppCache.isLoggedIn = true;
      AppCache().setFirebaseUser(user);
      await getUserData();
      print('login ${result.toString()}');
      return true;
    } catch (e) {
      print('errorss $e');
      return false;
    }
  }

  Future<bool> emailPasswordSignUp(String email, String password,
      String name) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      AppCache.isLoggedIn = true;
      AppCache().setFirebaseUser(user);
      await updateUser(user, name);
      await getUserData();
      print('sign up ${result.toString()}');
      return true;
    } catch (e) {
      print('errorss $e');
      return false;
    }
  }

  Future<bool> updateUser(FirebaseUser user, String name) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: user.uid)
        .getDocuments();
    final List<DocumentSnapshot> documents = result.documents;
    if (documents.length == 0)
      await Firestore.instance.collection('users').document(user.uid).setData({
        'email': user.email,
        'name': name,
        'id': user.uid,
        'photo_url':
            'https://firebasestorage.googleapis.com/v0/b/chat-app-368e8.appspot.com/o/avatar_icon_star_wars.jpg?alt=media&token=5725b940-8920-41b0-a898-18cd7f62de6d'
      });
    firebaseUser = user;
    await addDefaultCategory(user);
    return true;
  }

  Future<bool> addDefaultCategory(FirebaseUser user) async {
    Timestamp time = Timestamp.now();
    await Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('categories')
        .document()
        .setData({
      "time": time,
      "name": "Default",
      "color": Colors.grey.value,
    });
    return true;
  }

  @override
  void onDispose() {}
}
