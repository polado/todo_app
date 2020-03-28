import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/user_model.dart';
import 'package:todo_app/ui/pages/profile/edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseState<ProfilePage> {
  UserModel _user;

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.all(8),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: _signOut,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Text("Sign Out", style: TextStyle(fontSize: 16)),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection('users')
                  .document(AppCache().getFirebaseUser().uid)
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  _user = UserModel(snapshot.data);
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        elevation: 2,
                        clipBehavior: Clip.antiAlias,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: InkWell(
                          onTap: () async {
                            bool res = await navigateTo(EditProfilePage());
                            if (res)
                              showSuccessMsg("Profile Updated Successfully");
                          },
                          child: Container(
                            margin: EdgeInsets.all(16),
                            child: Row(
                              children: <Widget>[
                                ClipOval(
                                  clipBehavior: Clip.antiAlias,
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    child: Image.network(_user.photoUrl,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(_user.name,
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 4),
                                      Text(_user.email,
                                          style: TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(Icons.edit),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                    ],
                  );
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }

  _signOut() async {
    FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    await _firebaseAuth.signOut();
    Navigator.pop(context);
  }
}
