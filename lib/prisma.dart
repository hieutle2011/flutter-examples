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
// String after = 'ck0f3wumyr2u00b40ek1tp64g ';
// String before = 'ck0f3wumyr2u00b40ek1tp64g  ';

QueryOptions newOption(String document,
    {int pageSize, String after, String before}) {
  return QueryOptions(
    document: document,
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

Future<QueryResult> FuncPullRefresh(String before) async {
  QueryOptions options = newOption(
    PullRefresh,
    pageSize: pageSize,
    before: before,
  );
  return await _client.query(options);
}

Future<QueryResult> FuncLoadMore(String after) async {
  QueryOptions options = newOption(
    LoadMore,
    pageSize: pageSize,
    after: after,
  );
  return await _client.query(options);
}

void main() async {
  var beforeThisId = 'ck0f4dh73r3yu0b40saywadxh';
  QueryResult result = await FuncPullRefresh(beforeThisId);
  if (result.hasErrors) {
    print(result.errors);
  }
  // print(result.data is Map);
  // print(result.data['users'][0] is Map);
  print(result.data['users']);
  // var arr = result.data['users'].map((user) => {User.fromJson(user)});
  // print(arr);
  // var list = List.from(arr);
  // print(list[0] is User);
}
