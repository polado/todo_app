import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/base/base_bloc.dart';
import 'package:todo_app/base/base_view.dart';
import 'package:todo_app/core/app_cache.dart';

class RegisterBloc extends BaseBloc {
  FirebaseUser firebaseUser;

  RegisterBloc(BaseView view) : super(view);

  emailPasswordLogin(String email, String password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      firebaseUser = user;
      AppCache.isLoggedIn = true;
      AppCache().setFirebaseUser(user);
      print('login ${result.toString()}');
      return true;
    } catch (e) {
      print('errorss $e');
      return false;
    }
  }

  emailPasswordSignUp(String email, String password, String name) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      AppCache.isLoggedIn = true;
      AppCache().setFirebaseUser(user);
      await updateUser(user, name);
      print('sign up ${result.toString()}');
      return true;
    } catch (e) {
      print('errorss $e');
      return false;
    }
  }

  updateUser(FirebaseUser user, String name) async {
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
        'categories': FieldValue.arrayRemove([
          {'name': "Default", 'color': Colors.green.value}
        ]),
        'photo_url':
            'https://firebasestorage.googleapis.com/v0/b/chat-app-368e8.appspot.com/o/avatar_icon_star_wars.jpg?alt=media&token=5725b940-8920-41b0-a898-18cd7f62de6d'
      });
    firebaseUser = user;
    return true;
  }

  @override
  void onDispose() {}
}
