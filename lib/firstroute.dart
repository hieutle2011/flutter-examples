import 'package:flutter_web/material.dart';
import 'package:init/secondroute.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello, World!',
            ),
            RaisedButton(
              child: Text('Open route'),
              onPressed: () {
                // Navigate to second route when tapped.
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondRoute()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
