import 'package:flutter_web/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TextDemo(),
    );
  }
}
// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

String longtext =
    '''Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas auctor
vel ligula eget fermentum. Integer mattis nulla vitae ullamcorper
dignissim. Donec vel velit vel eros lobortis laoreet at sit amet turpis.
Ut in orci blandit, rhoncus metus quis, finibus augue. Nullam a elit
vel ligula eget fermentum. Integer mattis nulla vitae ullamcorper
dignissim. Donec vel velit vel eros lobortis laoreet at sit amet turpis.
Ut in orci blandit, rhoncus metus quis, finibus augue. Nullam a elit
vel ligula eget fermentum. Integer mattis nulla vitae ullamcorper
dignissim. Donec vel velit vel eros lobortis laoreet at sit amet turpis.
Ut in orci blandit, rhoncus metus quis, finibus augue. Nullam a elit
vel ligula eget fermentum. Integer mattis nulla vitae ullamcorper
dignissim. Donec vel velit vel eros lobortis laoreet at sit amet turpis.
Ut in orci blandit, rhoncus metus quis, finibus augue. Nullam a elit
vel ligula eget fermentum. Integer mattis nulla vitae ullamcorper
dignissim. Donec vel velit vel eros lobortis laoreet at sit amet turpis.
Ut in orci blandit, rhoncus metus quis, finibus augue. Nullam a elit
vel ligula eget fermentum. Integer mattis nulla vitae ullamcorper
dignissim. Donec vel velit vel eros lobortis laoreet at sit amet turpis.
Ut in orci blandit, rhoncus metus quis, finibus augue. Nullam a elit
vel ligula eget fermentum. Integer mattis nulla vitae ullamcorper
dignissim. Donec vel velit vel eros lobortis laoreet at sit amet turpis.
Ut in orci blandit, rhoncus metus quis, finibus augue. Nullam a elit
vel ligula eget fermentum. Integer mattis nulla vitae ullamcorper
dignissim. Donec vel velit vel eros lobortis laoreet at sit amet turpis.
Ut in orci blandit, rhoncus metus quis, finibus augue. Nullam a elit
venenatis metus accumsan dapibus. Vestibulum imperdiet tristique viverra.''';

class TextDemo extends StatelessWidget {
  // static const routeName = '/material/text';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
        centerTitle: true,
      ),
      body: pad(
        ListView(
          children: [
            pad(Text('Single line of text')),
            Divider(),
            pad(Text('     Text with       a   lot of    whitespace     ')),
            Divider(),
            pad(Text(
                'Text with a newline\ncharacter should render in 2 lines')),
            Divider(),
            pad(Text(
              longtext,
            )),
            Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('pressed');
        },
        child: Icon(Icons.send),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Padding pad(Widget child) => Padding(
        padding: EdgeInsets.all(12),
        child: child,
      );
}
