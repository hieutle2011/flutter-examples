import 'package:flutter_web/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FirstRoute extends StatelessWidget {
  FirstRoute({Key key, this.title, this.post}) : super(key: key);

  final String title;
  final Future<Post> post;

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
            Container(
              width: 400,
              height: 200,
              alignment: Alignment.center,
              color: Colors.amberAccent,
              child: FutureBuilder<Post>(
                // initialData: <Post>(ticketId = 'aaa', rewardId = 'bbb'),
                future: fetchPost(),
                builder: (context, snapshot) {
                  print(snapshot);
                  if (snapshot.hasData) {
                    return Text(snapshot.data.ticketId);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  print('here');
                  return CircularProgressIndicator();
                },
              ),
            ),
            Divider(),
            Text(
              'Hello, World!',
            ),
            Divider(),
            RaisedButton(
              child: Text('Draw Now!'),
              onPressed: () {
                print('pressed');
                fetchPost();
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

class Post {
  final String ticketId;
  final String rewardId;

  Post({this.ticketId, this.rewardId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        ticketId: json['result']['ticketId'],
        rewardId: json['result']['reward']['id']);
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

String url =
    'https://virtserver.swaggerhub.com/nguansak/lucky-draw/1.0.1/reward/draw';

Future<Post> fetchPost() async {
  final response = await http.post(url);
  print(response);

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON.
    var body = jsonDecode(response.body);
    print(body);
    return Post.fromJson(body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
