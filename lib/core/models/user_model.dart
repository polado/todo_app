import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String email;
  String id;
  String name;
  String photoUrl;

  UserModel(DocumentSnapshot snapshot) {
    email = snapshot['email'];
    name = snapshot['name'];
    photoUrl = snapshot['photo_url'];
    id = snapshot['id'];
  }

  UserModel.empty();
}
