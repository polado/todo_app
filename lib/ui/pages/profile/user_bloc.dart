import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_app/base/base_bloc.dart';
import 'package:todo_app/base/base_view.dart';
import 'package:todo_app/core/app_cache.dart';

class UserBloc extends BaseBloc {
  UserBloc(BaseView view) : super(view);

  updateUser(image, String name, String email) async {
    FirebaseUser user = AppCache().getFirebaseUser();
    view?.showLoading();
    if (image != null) {
      StorageUploadTask task = FirebaseStorage.instance
          .ref()
          .child('profile-pics/${user.uid}')
          .putFile(image);
      StorageTaskSnapshot snapshot = await task.onComplete;
      String url = await snapshot.ref.getDownloadURL();
      await Firestore.instance
          .collection('users')
          .document(user.uid)
          .updateData({'photo_url': url, 'name': name, 'email': email});
    } else {
      await Firestore.instance
          .collection('users')
          .document(user.uid)
          .updateData({'name': name, 'email': email});
    }
    view?.hideLoading();
    return true;
  }

  @override
  void onDispose() {}
}
