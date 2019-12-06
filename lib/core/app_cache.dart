import 'package:firebase_auth/firebase_auth.dart';

import 'models/user.dart';

class AppCache {
  static const String _KEY_USER = 'user';

  static bool isLoggedIn = false;

  static String apiToken;

  static FirebaseUser firebaseUser;
  static User loggedUser;
}
