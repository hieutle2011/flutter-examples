import 'package:flutter_web/material.dart';

class FirstRoute extends StatelessWidget {
  FirstRoute({Key key, this.title}) : super(key: key);

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
            Divider(),
            RaisedButton(
              child: Text('Draw Now!'),
              onPressed: () {
                print('pressed');
              },
            ),
            Divider(),
            RaisedButton(
              child: Text('Open route'),
              onPressed: () {
                // Navigate to second route when tapped.
                Navigator.pushNamed(context, '/second');
              },
            ),
            Divider(),
            RaisedButton(
              child: Text('Open box'),
              onPressed: () {
                // Navigate to second route when tapped.
                Navigator.pushNamed(context, '/box');
              },
            ),
          ],
        ),
      ),
    );
  }
}
