import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/core/blocs/main_bloc.dart';
import 'package:todo_app/ui/pages/host/host_page.dart';
import 'package:todo_app/ui/pages/register/register_page.dart';

void main() => runApp(BotToastInit(child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        accentColor: Color(0xFFff8463),
        cardColor: Colors.white,
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
        appBarTheme: AppBarTheme(
            color: Color(0xFFF5F5F5), elevation: Constants.elevation),
        buttonColor: Colors.cyan,
      ),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {
  MainBloc bloc;

  @override
  void initState() {
    bloc = new MainBloc(this);
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return StreamBuilder(
      stream: bloc.mainController,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) return RegisterPage();
          AppCache().setFirebaseUser(user);
          AppCache.isLoggedIn = true;
          return HostPage();
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
