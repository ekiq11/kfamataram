import 'package:flutter/material.dart';
import 'package:kf_online/view/home.dart';

/// {@template counter_app}
/// A [MaterialApp] which sets the `home` to [CounterPage].
/// {@endtemplate}
class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 32.0, color: Colors.teal[500], fontFamily: 'Raleway'),
          headline2: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w400,
              color: Colors.teal[500],
              fontFamily: 'Raleway'),
          bodyText1: TextStyle(
              fontSize: 16.0,
              color: Colors.teal[500],
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700),
          bodyText2: TextStyle(
              fontSize: 16.0,
              height: 1.3,
              color: Colors.black45,
              fontWeight: FontWeight.w300),
          button: TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w700),
        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(child: Scaffold(body: HomePage())),
      debugShowCheckedModeBanner: false,
    );
  }
}
