import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/core/models/category_model.dart';

import 'models/user_model.dart';

class AppCache {
  static final AppCache _instance = AppCache._private();

  AppCache._private();

  factory AppCache() {
    return _instance;
  }

//  static const String _KEY_USER = 'user';

  static bool isLoggedIn = false;

  static String apiToken;

  FirebaseUser firebaseUser;
  UserModel user;
  List<CategoryModel> categories;

  void setFirebaseUser(FirebaseUser firebaseUser) {
    this.firebaseUser = firebaseUser;
  }

  FirebaseUser getFirebaseUser() {
    return firebaseUser;
  }

  void setUser(UserModel user) {
    this.user = user;
  }

  UserModel getUser() {
    return user;
  }

  void setCategories(List<CategoryModel> categories) {
    this.categories = categories;
  }

  List<CategoryModel> getCategories() {
    return categories;
  }
}
