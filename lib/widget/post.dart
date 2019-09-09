import 'package:flutter_web/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'data.dart';

class Post {
  final String ticketId;
  final String rewardId;
  final String message;

  Post({this.ticketId, this.rewardId, this.message});

  factory Post.fromJson(Map<String, dynamic> json) {
    print(json);

    if (json['code'] == 200) {
      return Post(
          ticketId: json['result']['ticketId'],
          rewardId: json['result']['reward']['id'],
          message: 'success');
    } else {
      return Post(ticketId: '', rewardId: '', message: json['message']);
    }
    //
    // Example draw result
    // {
    //   "code": 200,
    //   "result": {
    //     "ticketId": "d9f1adca-7fc2-4282-af33-d9c5a2b46a9a",
    //     "reward": {
    //       "id": "d290f1ee-6c54-4b01-90e6-d701748f0851"
    //     }
    //   }
    // }
  }
}

Future<Post> fetchPost(String url) async {
  final response = await http.post(url, body: {'playerId': '123'});

  if (response.statusCode == 200 || response.statusCode == 400) {
    // If server returns an OK response, parse the JSON.
    var body = jsonDecode(response.body);
    // print(body);
    return Post.fromJson(body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

void _fetchReload(String url) {
  http.post(url, body: {'playerId': '123'});
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
          FutureBuilder<Post>(
            future: fetchPost(url),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String message = snapshot.data.message;
                if (message == 'success') {
                  String ticketId = snapshot.data.ticketId;
                  String rewardId = snapshot.data.rewardId;
                  return Column(
                    children: <Widget>[
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
