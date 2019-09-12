import 'package:graphql/client.dart';

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
  query PullRefresh($pageSize: Int) {
    users (last: $pageSize, before:"ck0f3wumyr2u00b40ek1tp64g",  orderBy: id_DESC) {
      id
      name 
    }
  }
''';

const String LoadMore = r'''
  query LoadMore($pageSize: Int) {
    users (first: $pageSize, after:"ck0f3tjcyr2m00b40ypltsxxe",  orderBy: id_DESC) {
      id
      name 
    }
  }
''';

const int pageSize = 2;

final QueryOptions options = QueryOptions(
  document: LoadNew,
  variables: <String, dynamic>{'pageSize': pageSize},
);

void main() async {
  final QueryResult result = await _client.query(options);
  if (result.hasErrors) {
    print(result.errors);
  }

  print(result.data['users']);
}
