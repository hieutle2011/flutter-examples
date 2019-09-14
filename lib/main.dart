// import 'package:flutter_web/gestures.dart';
import 'package:flutter_web/material.dart';

import 'prisma.dart';
import 'user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
  String message = "Scroll Status";
  ScrollController _controller;
  List<User> allUsers = [];
  String lastId = '';
  String topId = '';

  _scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent) {
      print('bottom');
      load();
      setState(() {
        message = 'reach the bottom = max scroll';
      });
    } else if (_controller.offset <= _controller.position.minScrollExtent) {
      print('top');
      pull();
      setState(() {
        message = 'reach the top = min scroll';
      });
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    // Load initial data from query
    FuncLoadNew().then((List<User> res) {
      setState(() {
        allUsers.addAll(res);
        topId = allUsers[0].getId();
        lastId = allUsers[allUsers.length - 1].getId();
      });
    });
    super.initState();
  }

  void pull() async {
    print('click pull - topId $topId');
    var result = await FuncPullRefresh(topId);
    print('click pull result empty? ${result.isEmpty}');
    print('---------------------');
    if (result.isNotEmpty) {
      String newTop = result[0].getId();
      setState(() {
        allUsers.insertAll(0, result);
        topId = newTop;
      });
    }
  }

  void load() async {
    print('click load - lastId $lastId');
    var result = await FuncLoadMore(lastId);
    print('click load result empty? ${result.isEmpty}');
    print('---------------------');
    if (result.isNotEmpty) {
      String newLast = result[result.length - 1].getId();
      setState(() {
        allUsers.addAll(result);
        lastId = newLast;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scroll Limit reached"),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.new_releases),
          //   onPressed: () => test(),
          //   tooltip: "Load New",
          // ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => pull(),
            tooltip: "Pull Refresh",
          ),
          IconButton(
            icon: Icon(Icons.more),
            onPressed: () => load(),
            tooltip: "Load More",
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
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              // dragStartBehavior: DragStartBehavior.down,
              controller: _controller,
              itemCount: allUsers.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.face),
                  title: Text("Index : $index - ${allUsers[index].getName()}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
