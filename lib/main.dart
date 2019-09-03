import 'package:flutter_web/material.dart';
import 'firstroute.dart';
import 'secondroute.dart';
import 'box_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstRoute widget.
        '/': (context) => FirstRoute(title: 'Flutter Demo Home Page'),
        '/second': (context) => SecondRoute(),
        '/box': (context) => MyHomePage(title: 'Animated Box'),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

