import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/models/user_model.dart';
import 'package:todo_app/ui/widgets/text_field_widget.dart';

import 'user_bloc.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends BaseState<EditProfilePage> {
  UserModel _user;
  File _selectedImage;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();

  UserBloc bloc;

  @override
  void initState() {
    bloc = new UserBloc(this);
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.check), onPressed: _submit),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: StreamBuilder(
          stream: Firestore.instance
              .collection('users')
              .document(AppCache().getFirebaseUser().uid)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              _user = UserModel(snapshot.data);
              _nameController.text = _user.name;
              _emailController.text = _user.email;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Center(
                    child: InkWell(
                      onTap: _selectImage,
                      borderRadius: BorderRadius.circular(45),
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.all(8),
                        child: ClipOval(
                          clipBehavior: Clip.antiAlias,
                          child: _selectedImage == null
                              ? Image.network(_user.photoUrl, fit: BoxFit.cover)
                              : Image.file(_selectedImage, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  TextFieldWidget(
                    controller: _emailController,
                    label: "Email",
                    prefixIcon: Icons.email,
                  ),
                  SizedBox(height: 16),
                  TextFieldWidget(
                    controller: _nameController,
                    label: "Name",
                    prefixIcon: Icons.account_circle,
                  ),
                ],
              );
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  void _selectImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImage = image;
    });
  }

  bool _validate() {
    if (_nameController.text.trim().isEmpty) {
      showErrorMsg("Please enter your name");
      return false;
    } else if (_nameController.text.trim().length < 4) {
      showErrorMsg("Name must be at least 4 characters");
      return false;
    } else if (_emailController.text.trim().isEmpty) {
      showErrorMsg("Please enter your email");
      return false;
    } else if (!EmailValidator.validate(_emailController.text.trim(), true)) {
      showErrorMsg("Please enter valid email");
      return false;
    }
    return true;
  }

  _submit() async {
    if (_validate()) {
      bool res = await bloc.updateUser(_selectedImage,
          _nameController.text.trim(), _emailController.text.trim());
      Navigator.pop(context, res);
    }
  }
}
