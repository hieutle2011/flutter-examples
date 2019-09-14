import 'package:graphql/client.dart';
// import 'dart:convert';

import 'user.dart';

final HttpLink _httpLink = HttpLink(
  uri: 'https://us1.prisma.sh/hieuletrung102-9dd903/hello-world/dev',
);

final GraphQLClient _client = GraphQLClient(
  cache: InMemoryCache(),
  link: _httpLink,
);

const String LOADNEW = r'''
  query {
    users (first:2,  orderBy: id_DESC) {
    id
    name
    }
  }
''';

const String PULLREFRESH = r'''
  query ($pageSize: Int, $before: String) {
    users (last: $pageSize, before: $before,  orderBy: id_DESC) {
      id
      name 
    }
  }
''';

const String LOADMORE = r'''
  query ($pageSize: Int, $after: String) {
    users (first: $pageSize, after: $after,  orderBy: id_DESC) {
      id
      name 
    }
  }
''';

int pageSize = 2;

QueryOptions newOption(String document,
    {int pageSize, String after, String before}) {
  return QueryOptions(
    document: document,
    variables: <String, dynamic>{
      'pageSize': pageSize,
      'after': after,
      'before': before,
    },
    fetchPolicy: FetchPolicy.networkOnly,
  );
}

Future<List<User>> FuncLoadNew() async {
  QueryOptions options = newOption(LOADNEW);
  final result = await _client.query(options);
  return parseUser(result);
}

Future<List<User>> FuncPullRefresh(String before) async {
  QueryOptions options = newOption(
    PULLREFRESH,
    pageSize: pageSize,
    before: before,
  );
  final result = await _client.query(options);
  return parseUser(result);
}

Future<List<User>> FuncLoadMore(String after) async {
  QueryOptions options = newOption(
    LOADMORE,
    pageSize: pageSize,
    after: after,
  );
  final result = await _client.query(options);
  return parseUser(result);
}

List<User> parseUser(QueryResult result) {
  if (result.hasErrors) {
    throw Exception('Failed to load post');
  } else {
    var data = result.data;
    var mapUsers = data['users'];
    print('map user $mapUsers');
    List<User> arrUsers =
        mapUsers.map<User>((user) => User.fromJson(user)).toList();
    return arrUsers;
  }
}

// void main() async {
//   var beforeThisId = 'ck0f3tjcyr2m00b40ypltsxxe';
//   var result = await FuncPullRefresh(beforeThisId);

//   print(result);
// }
