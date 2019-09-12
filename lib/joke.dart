import 'package:http/http.dart' as http;
import 'dart:convert';

class Joke {
  final String id;
  final String content;
  final int status;

  Joke({this.id, this.content, this.status});

  factory Joke.fromJson(Map<String, dynamic> json) {
    if (json['status'] == 200) {
      return Joke(
        id: json['id'],
        content: json['joke'],
        status: json['status'],
      );
    } else {
      print(json['status']);
      return Joke(id: null, content: null, status: json['status']);
    }
  }
}

Future<Joke> fetchJoke() async {
  String url = 'https://icanhazdadjoke.com/';
  Map<String, String> header = {
    "Accept": "application/json",
    "User-Agent": "https://github.com/hieutle2011"
  };
  http.Response response = await http.get(url, headers: header);
  if (response.statusCode == 200) {
    var body = json.decode(response.body);
    return Joke.fromJson(body);
  } else {
    throw Exception('Failed to load joke');
  }
}
