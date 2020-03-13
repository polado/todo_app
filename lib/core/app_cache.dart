import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';

class AppCache {
  static final AppCache _instance = AppCache._private();

  AppCache._private();

  static AppCache get instance {
    return _instance;
  }

  static const String _KEY_USER = 'user';

  static bool isLoggedIn = false;

  static String apiToken;

  FirebaseUser firebaseUser;
  static User loggedUser;

  void setUser(FirebaseUser firebaseUser) {
    this.firebaseUser = firebaseUser;
  }

  FirebaseUser getUser() {
    return firebaseUser;
  }
}
