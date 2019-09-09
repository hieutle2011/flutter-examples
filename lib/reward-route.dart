import 'package:flutter_web/material.dart';
import 'widget/reward.dart';
import 'widget/data.dart';

import 'dart:html';
import 'dart:convert';

class RewardRoute extends StatelessWidget {
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

void _fetchReload(String url) async {
  var body = {'quota': 5, 'playerId': '123'};
  var header = {'Content-Type': 'application/json; charset=UTF-8'};
  var res = await HttpRequest.request(url,
      method: 'POST', sendData: json.encode(body), requestHeaders: header);
  print(res.status);
  // return res.status;
}

void _invokeSnackBar(BuildContext context) {
  final bar =
      SnackBar(content: Text("Quota was reloaded. Try your luck again."));
  print('tapp');
  Scaffold.of(context).showSnackBar(bar);
}

Container _textBuilder(String text, double size, FontWeight weight) {
  return Container(
    padding: EdgeInsets.only(top: 12, left: 32, right: 32),
    child: Text(
      text,
      // softWrap: true,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: Colors.black87,
      ),
    ),
  );
}

class AwardPost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          FutureBuilder<Reward>(
            future: fetchPost(url),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String message = snapshot.data.message;
                if (message == 'success') {
                  String ticketId = snapshot.data.ticketId;
                  String rewardId = snapshot.data.rewardId;
                  return Column(
                    children: <Widget>[
                      // debug purpose
                      // RaisedButton(
                      //   onPressed: () => _fetchReload(reload_url),
                      //   child: Text('Reload'),
                      // ),
                      _textBuilder('Your award', 12, FontWeight.bold),
                      Container(
                        child: Image.asset(pic[rewardId]),
                        width: 300,
                        height: 300,
                        alignment: Alignment.center,
                      ),
                      _textBuilder(
                          'Ticket ID is ${ticketId}', 12, FontWeight.w300),
                      _textBuilder(
                          'Reward ID is ${rewardId}', 12, FontWeight.w300),
                      _textBuilder(intro, 12, FontWeight.normal),
                    ],
                  );
                } else {
                  return Column(
                    children: <Widget>[
                      _textBuilder('${message}', 20, FontWeight.w900),
                      _textBuilder('Please try again!', 16, FontWeight.w300),
                      Container(
                        height: 200,
                      ),
                      RaisedButton(
                        textColor: Colors.white,
                        child: Text('Dev Mode: Reload quota!'),
                        onPressed: () {
                          _fetchReload(reload_url);
                          _invokeSnackBar(context);
                        },
                        color: Theme.of(context).hintColor,
                      ),
                    ],
                  );
                }
              } else if (snapshot.hasError) {
                // return Text('${snapshot.error}');
                return _textBuilder('${snapshot.error}', 20, FontWeight.w900);
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }
}
