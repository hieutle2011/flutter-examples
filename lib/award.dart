import 'package:flutter_web/material.dart';
import 'widget/post.dart';

class AwardRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Congratulation"),
      ),
      body: ListView(
        children: <Widget>[
          AwardPost(),
        ],
      ),
    );
  }
}
