import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/core/models/category_model.dart';

class UserModel {
  String email;
  String id;
  String name;
  String photoUrl;
  List<CategoryModel> categories;

  UserModel(DocumentSnapshot snapshot) {
    email = snapshot['email'];
    name = snapshot['name'];
    photoUrl = snapshot['photo_url'];
    id = snapshot['id'];
    categories = new List();
    var list = List.from(snapshot['categories']);
    for (int i = 0; i < list.length; i++) {
      categories.add(new CategoryModel.firebase(list[i]));
    }
  }

  UserModel.empty();
}
