import 'package:graphql/client.dart';

import 'user.dart';

final HttpLink _httpLink = HttpLink(
  uri: 'https://us1.prisma.sh/hieuletrung102-9dd903/hello-world/dev',
);

final GraphQLClient _client = GraphQLClient(
  cache: InMemoryCache(),
  link: _httpLink,
);

const String LoadNew = r'''
  query LoadNew {
    users (first:2,  orderBy: id_DESC) {
    id
    name
    }
  }
''';

const String PullRefresh = r'''
  query PullRefresh($pageSize: Int, $before: String) {
    users (last: $pageSize, before: $before,  orderBy: id_DESC) {
      id
      name 
    }
  }
''';

const String LoadMore = r'''
  query LoadMore($pageSize: Int, $after: String) {
    users (first: $pageSize, after: $after,  orderBy: id_DESC) {
      id
      name 
    }
  }
''';

int pageSize = 2;
String after = 'ck0f3wumyr2u00b40ek1tp64g ';
String before = 'ck0f3wumyr2u00b40ek1tp64g  ';

// final QueryOptions options = QueryOptions(
//   document: LoadNew,
//   variables: <String, dynamic>{'pageSize': pageSize},
// );

QueryOptions newOption(String doc) {
  return QueryOptions(
    document: doc,
    variables: <String, dynamic>{
      'pageSize': pageSize,
      'after': after,
      'before': before,
    },
  );
}

Future<QueryResult> FuncLoadNew() async {
  QueryOptions options = newOption(LoadNew);
  return await _client.query(options);
}

Future<QueryResult> FuncPullRefresh() async {
  QueryOptions options = newOption(PullRefresh);
  return await _client.query(options);
}

Future<QueryResult> FuncLoadMore() async {
  QueryOptions options = newOption(LoadMore);
  return await _client.query(options);
}

void main() async {
  QueryResult result = await FuncPullRefresh();
  if (result.hasErrors) {
    print(result.errors);
  }
  // print(result.data is Map);
  print(result.data['users'][0] is Map);
  print(result.data['users'][0]);
  var arr = result.data['users'].map((user) => {User.fromJson(user)});
  print(arr);
  var list = List.from(arr);
  print(list[0] is User);
}
