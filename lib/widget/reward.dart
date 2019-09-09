// import 'package:flutter_web/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Reward {
  final String ticketId;
  final String rewardId;
  final String message;

  Reward({this.ticketId, this.rewardId, this.message});

  factory Reward.fromJson(Map<String, dynamic> json) {
    print(json);

    if (json['code'] == 200) {
      return Reward(
          ticketId: json['result']['ticketId'],
          rewardId: json['result']['reward']['id'],
          message: 'success');
    } else {
      return Reward(ticketId: '', rewardId: '', message: json['message']);
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

Future<Reward> fetchPost(String url) async {
  final response = await http.post(url, body: {'playerId': '123'});

  if (response.statusCode == 200 || response.statusCode == 400) {
    // If server returns an OK response, parse the JSON.
    var body = jsonDecode(response.body);
    // print(body);
    return Reward.fromJson(body);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}
