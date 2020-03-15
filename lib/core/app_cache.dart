import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';

class AppCache {
  static final AppCache _instance = AppCache._private();

  AppCache._private();

  factory AppCache() {
    return _instance;
  }

  static const String _KEY_USER = 'user';

  static bool isLoggedIn = false;

  static String apiToken;

  FirebaseUser firebaseUser;
  UserModel user;

  void setFirebaseUser(FirebaseUser firebaseUser) {
    print("object setFirebaseUser");
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
}
