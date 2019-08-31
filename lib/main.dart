import 'package:flutter_web/material.dart';
// Fix icon render issue https://github.com/flutter/flutter/issues/32540

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WIP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Business Card Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(15.0),
          padding: const EdgeInsets.all(5.0),
          width: 350.0,
          // height: 200,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: SizedBoxWrapper(),
        ),
      ),
    );
  }
}

class SizedBoxWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        NameWithIcon(),
        SizedBox(
          height: 8,
        ),
        ContactRow(), // add contact info
        SizedBox(
          height: 16,
        ),
        IconRow(), // add 4 icons
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}

class ContactRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text('123 Main Street'),
        Text('(415) 555-0198'),
      ],
    );
  }
}

class IconRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Icon(Icons.accessibility),
        Icon(Icons.timer),
        Icon(Icons.phone_android),
        Icon(Icons.phone_iphone),
      ],
    );
  }
}

class NameWithIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(
            Icons.account_circle,
            size: 50,
          ),
        ),
        MyName(),
      ],
    );
  }
}

class MyName extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter McFlutter',
          style: Theme.of(context).textTheme.headline,
        ),
        Text('Experienced Developer'),
      ],
    );
  }
}
