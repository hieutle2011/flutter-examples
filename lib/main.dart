import 'package:flutter_web/material.dart';
import 'package:graphql/client.dart';
// import 'package:graphql/client.dart';

import 'prisma.dart';
import 'user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  String message = "max Scroll or min Scroll";
  ScrollController _controller;
  Future<QueryResult> future;
  bool mode = true;
  // List<dynamic> sampleData = [
  //   User(id: '1', name: 'abc 1'),
  //   User(id: '2', name: 'abc 2'),
  //   User(id: '3', name: 'abc 3'),
  //   User(id: '4', name: 'abc 4'),
  //   User(id: '5', name: 'abc 5'),
  // ];

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent) {
      setState(() {
        message = 'reach the bottom = max scroll';
      });
    } else if (_controller.offset <= _controller.position.minScrollExtent) {
      setState(() {
        message = 'reach the top = min scroll';
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    future = FuncPullRefresh();
    super.initState();
  }

  void loadNew() {
    print('click');
    setState(() {
      future = FuncLoadNew();
    });
  }

  void pullRefresh() {
    setState(() {
      future = FuncPullRefresh();
    });
  }

  void loadMore() {
    setState(() {
      future = FuncLoadMore();
    });
  }

  void changeMode() {
    setState(() {
      mode = !mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Limit reached"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.new_releases),
            onPressed: () => loadNew(),
            tooltip: "Load New",
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => pullRefresh(),
            tooltip: "Pull Refresh",
          ),
          IconButton(
            icon: Icon(Icons.more),
            onPressed: () => loadMore(),
            tooltip: "Load More",
          ),
          IconButton(
            icon: Icon(Icons.mode_edit),
            onPressed: () => changeMode(),
            tooltip: "Change Scroll Data",
          ),
        ],
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
          mode
              ? FutureBuilder(
                  future: future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      List<dynamic> users = snapshot.data.data['users']
                          .map((user) => User.fromJson(user))
                          .toList();
                      return Expanded(
                        child: ListView.builder(
                          // reverse: true,
                          controller: _controller,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Icon(Icons.face),
                              title: Text(
                                  "Index : $index - ${users[index].getName()}"),
                            );
                          },
                        ),
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )
              : Expanded(
                  child: ListView.builder(
                    // reverse: true,
                    controller: _controller,
                    itemCount: 15,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(Icons.list),
                        title: Text("Index : $index"),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
