import 'package:flutter_web/material.dart';

import 'joke.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Joke> joke;

  @override
  void initState() {
    super.initState();
    joke = fetchJoke();
  }

  void _newJoke() {
    setState(() {
      joke = fetchJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('widget.title'),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            JokePanel(joke: joke),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _newJoke,
        tooltip: 'New joke!',
        child: Icon(Icons.sentiment_very_satisfied),
      ),
    );
  }
}

class JokePanel extends StatelessWidget {
  final Future<Joke> joke;

  JokePanel({Key key, this.joke}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: joke,
      builder: (context, snapshot) {
        // we have a joke
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data.status == 200) {
            // String id = snapshot.data.id;
            String jokeContent = snapshot.data.content;
            // int status = snapshot.data.status;
            return Container(
              child: Text(jokeContent),
            );

            // something goes wrong
          } else if (snapshot.hasError) {
            return Container(
              child: Text('${snapshot.error}'),
            );
          }
        }

        // we are still loading
        return CircularProgressIndicator();
      },
    );
  }
}
