import 'package:flutter_web/material.dart';
// import 'package:graphql/client.dart';

import 'prisma.dart';
// import 'user.dart';

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
      home: HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = "abc";
  ScrollController _controller;
  // final List<Map<String, String>> _notifications = <Map<String, String>>[];

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent) {
      setState(() {
        message = 'reach the bottom';
      });
    } else if (_controller.offset <= _controller.position.minScrollExtent) {
      setState(() {
        message = 'reach the top';
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Limit reached"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(
              child: Text(message),
            ),
          ),
          FutureBuilder(
            future: FuncPullRefresh(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                var data = snapshot.data.data['users'][0]['name'];
                List<dynamic> users = snapshot.data.data['users'];
                print('data is ${data}');
                print('users is ${users}');
                // return Container(child: Text('data'));
                return Expanded(
                  child: ListView.builder(
                    // reverse: true,
                    controller: _controller,
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.message),
                        // title: Text("Index : $index"),
                        title: Text("Index : $index ${users[index]['name']}"),
                        // subtitle: Text('Name: ${users[index].name}'),
                      );
                    },
                  ),
                );
              } else {
                return CircularProgressIndicator();
              }
            },
          ),

          // Expanded(
          //   child: ListView.builder(
          //     reverse: true,
          //     controller: _controller,
          //     itemCount: 15,
          //     itemBuilder: (context, index) {
          //       return ListTile(
          //         leading: Icon(Icons.message),
          //         title: Text("Index : $index"),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
