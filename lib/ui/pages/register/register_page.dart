import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/ui/pages/register/register_bloc.dart';
import 'package:todo_app/ui/widgets/flat_button_widget.dart';
import 'package:todo_app/ui/widgets/password_text_field_widget.dart';
import 'package:todo_app/ui/widgets/text_field_widget.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage> {
  bool _isLogin = true;

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = new RegisterBloc(this);
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[
          FlatButton(
            onPressed: () {},
            child: Text('Skip', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
      body: Card(
        elevation: Constants.elevation,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.cardRadius)),
        child: Container(
          padding: EdgeInsets.all(16),
          child: ListView(
            children: <Widget>[
              SizedBox(height: 16),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButtonWidget(
                      callback: () {
                        if (!_isLogin)
                          setState(() {
                            _isLogin = true;
                          });
                      },
                      color: _isLogin
                          ? Theme.of(context).buttonColor
                          : Colors.white,
                      text: "Login",
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: FlatButtonWidget(
                      callback: () {
                        if (_isLogin)
                          setState(() {
                            _isLogin = false;
                          });
                      },
                      color: !_isLogin
                          ? Theme.of(context).buttonColor
                          : Colors.white,
                      text: "Sign up",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Visibility(visible: !_isLogin, child: SizedBox(height: 16)),
              AnimatedSwitcher(
                child: !_isLogin
                    ? TextFieldWidget(
                        controller: _nameController,
                        label: "Name",
                        prefixIcon: Icons.account_circle,
                      )
                    : Container(),
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                duration: Duration(milliseconds: 100),
                reverseDuration: Duration(milliseconds: 0),
              ),
              SizedBox(height: 16),
              TextFieldWidget(
                controller: _emailController,
                label: "Email",
                prefixIcon: Icons.email,
              ),
              SizedBox(height: 16),
              PasswordFieldWidget(
                controller: _passwordController,
                label: "Password",
              ),
              SizedBox(height: 32),
              FlatButtonWidget(
                callback: _submit,
                color: Theme.of(context).accentColor,
                textStyle: TextStyle(fontSize: 16),
                text: _isLogin ? "Login" : "Sign up",
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  bool _validate() {
    if (!_isLogin && _nameController.text.isEmpty) {
      showErrorMsg("Please enter your name");
      return false;
    } else if (!_isLogin && _nameController.text.length < 4) {
      showErrorMsg("Name must be at least 4 characters");
      return false;
    } else if (_emailController.text.isEmpty) {
      showErrorMsg("Please enter your email");
      return false;
    } else if (!EmailValidator.validate(_emailController.text, true)) {
      showErrorMsg("Please enter valid email");
      return false;
    } else if (_passwordController.text.isEmpty) {
      showErrorMsg("Please enter your password");
      return false;
    } else if (_passwordController.text.length < 6) {
      showErrorMsg("Password must be at least 6 characters");
      return false;
    }
    return true;
  }

  void _submit() async {
    if (_validate()) {
      showLoading();
      if (_isLogin) {
        bool res = await _registerBloc.emailPasswordLogin(
            _emailController.text.trim(), _passwordController.text.trim());
        hideLoading();
        if (!res) showErrorMsg("Something went wrong");
      } else {
        bool res = await _registerBloc.emailPasswordSignUp(
            _emailController.text.trim(),
            _passwordController.text.trim(),
            _nameController.text.trim());
        hideLoading();
        if (!res) showErrorMsg("User data not found!");
      }
    }
  }
}
