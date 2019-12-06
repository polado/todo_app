import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';
import 'package:todo_app/core/blocs/register_bloc.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  List<bool> isSelected;
  String email = '', password = '', name = '';

  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[
          FlatButton(
              onPressed: () {},
              child: Text(
                'Skip',
                style: TextStyle(fontSize: 16),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 8),
                alignment: AlignmentDirectional.center,
                child: ToggleButtons(
                  isSelected: isSelected,
                  fillColor: Theme.of(context).accentColor,
                  selectedColor: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  onPressed: (int index) {
                    setState(() {
                      for (int i = 0; i < isSelected.length; i++) {
                        if (i == index) {
                          isSelected[i] = true;
                        } else {
                          isSelected[i] = false;
                        }
                      }
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      child: Text(
                        ' Login ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      child: Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 32)),
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 24)),
                        Visibility(
                          visible: isSelected[1],
                          child: TextFormField(
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.account_circle),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                labelText: 'Name'),
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Please enter name';
                              else if (value.length < 4)
                                return 'Name must be at least 4 characters';
                              return null;
                            },
                            onSaved: (String value) {
                              setState(() {
                                name = value;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: isSelected[1],
                          child: Padding(padding: EdgeInsets.only(top: 16)),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'Please enter email';
                            else if (!EmailValidator.validate(value, true))
                              return 'Please enter valid email';
                            return null;
                          },
                          onSaved: (String value) {
                            setState(() {
                              email = value;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 16)),
                        TextFormField(
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.remove_red_eye,
                                    color: _obscureText
                                        ? Colors.grey
                                        : Theme.of(context).accentColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  }),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              labelText: 'Password'),
                          validator: (String value) {
                            if (value.isEmpty)
                              return 'Please enter password';
                            else if (value.length < 6)
                              return 'Password must be at least 6 characters';
                            return null;
                          },
                          onSaved: (String value) {
                            setState(() {
                              password = value;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.only(top: 24)),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8)),
                          child: FlatButton(
                            padding: EdgeInsets.all(16),
                            color: Theme.of(context).buttonColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              isSelected[1] ? 'Sign Up' : 'Login',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            onPressed: () {
                              isSelected[1] ? _signUp() : _login();
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _validate() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      return true;
    }
    return false;
  }

  _signUp() async {
    if (_validate()) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal,
          isDismissible: false,
          showLogs: false);
      pr.style(
          progressWidget: Center(child: CircularProgressIndicator()),
          message: 'Creating your account...',
          borderRadius: 8);
      pr.show();

      bool res = await registerBloc.emailPasswordSignUp(email, password, name);
      pr.dismiss();
      if (!res)
        Toast.show('Something went wrong', context,
            backgroundColor: Theme.of(context).accentColor,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundRadius: 80);
    }
  }

  _login() async {
    if (_validate()) {
      ProgressDialog pr = new ProgressDialog(context,
          type: ProgressDialogType.Normal,
          isDismissible: false,
          showLogs: false);
      pr.style(
          progressWidget: Center(child: CircularProgressIndicator()),
          message: 'Loging in...',
          borderRadius: 8);
      pr.show();

      bool res = await registerBloc.emailPasswordLogin(email, password);
      pr.dismiss();
      if (!res)
        Toast.show('User data not found!', context,
            backgroundColor: Theme.of(context).accentColor,
            duration: Toast.LENGTH_LONG,
            gravity: Toast.CENTER,
            backgroundRadius: 80);
    }
  }
}
