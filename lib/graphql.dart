import 'package:graphql/client.dart';

import 'local.dart';

final HttpLink _httpLink = HttpLink(
  uri: 'https://api.github.com/graphql',
);

final AuthLink _authLink = AuthLink(
  getToken: () async => 'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
);

final Link _link = _authLink.concat(_httpLink);

final GraphQLClient _client = GraphQLClient(
  cache: InMemoryCache(),
  link: _link,
);

const String readRepositories = r'''
  query ReadRepositories($nRepositories: Int!) {
    viewer {
      repositories(last: $nRepositories) {
        nodes {
          __typename
          id
          name
          viewerHasStarred
        }
      }
    }
  }
''';

const int nRepositories = 50;

final QueryOptions options = QueryOptions(
    document: readRepositories,
    variables: <String, dynamic>{'nRepositories': nRepositories});

void main() async {
  final QueryResult result = await _client.query(options);

  if (result.hasErrors) {
    print(result.errors);
  }

  final List<dynamic> repositories =
      result.data['viewer']['repositories']['nodes'] as List<dynamic>;

  print(repositories);
}
