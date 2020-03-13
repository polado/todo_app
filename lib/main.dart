import 'package:bot_toast/bot_toast.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/base/base_state.dart';
import 'package:todo_app/constants.dart';
import 'package:todo_app/core/app_cache.dart';
import 'package:todo_app/themes.dart';
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
  @override
  Widget buildWidget(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          if (user == null) return RegisterPage();
          AppCache.instance.setUser(user);
          AppCache.isLoggedIn = true;
          return HostPage();
        } else {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  bool dayOrNight = false;
  bool switchDayOrNight = false;
  String animation = 'night_idle';

  switchTheme() async {
    print('switchdayornight $switchDayOrNight $dayOrNight');

    if (switchDayOrNight && dayOrNight) {
      setState(() {
        animation = 'switch_day';
        DynamicTheme.of(context).setThemeData(CustomTheme.lightTheme());
        switchDayOrNight = false;
      });
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        animation = 'day_idle';
      });
    } else if (!switchDayOrNight && dayOrNight) {
      setState(() {
        animation = 'day_idle';
      });
    } else if (switchDayOrNight && !dayOrNight) {
      setState(() {
        animation = 'switch_night';

        DynamicTheme.of(context).setThemeData(CustomTheme.darkTheme());
        switchDayOrNight = false;
      });
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        animation = 'night_idle';
      });
    } else {
      setState(() {
        animation = 'night_idle';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: GestureDetector(
              child: FlareActor(
                'assets/switch_day_night_theme.flr',
                animation: animation,
                fit: BoxFit.scaleDown,
              ),
              onTap: () {
                dayOrNight = !dayOrNight;
                switchDayOrNight = !switchDayOrNight;
                switchTheme();
              },
            ),
            width: 75,
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
//          CategoryWidget(
//            category: new Category(name: 'Main Category', color: 'red', tasks: [
//              new Task(
//                  title: 'Title',
//                  isDone: true,
//                  description:
//                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.'),
//              new Task(
//                  title: 'Title',
//                  isDone: false,
//                  description:
//                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.')
//            ]),
//          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.display1,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
